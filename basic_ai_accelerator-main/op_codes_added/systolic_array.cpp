#include "systolic_controller.h"
#include <cmath>
#include <iostream>

//=======================================
// Constants (Fixed-Point)
//=======================================
const acc_t ZERO   = (acc_t)0.0;
const acc_t ONE    = (acc_t)1.0;
const acc_t TWO    = (acc_t)2.0;
const acc_t SIX    = (acc_t)6.0;
const acc_t TWELVE = (acc_t)12.0;
const acc_t ALPHA  = (acc_t)0.1;  // For Leaky ReLU

// Learning rate for SGD
const acc_t LR = (acc_t)0.01;

//=======================================
// Activation / Utility Functions
//=======================================
acc_t relu(acc_t x) {
    return (x > ZERO) ? x : ZERO;
}

acc_t leaky_relu(acc_t x) {
    return (x > ZERO) ? x : (acc_t)(x * ALPHA);
}

// Sigmoid: we can make a simple piecewise approximation, or a direct approach:
acc_t sigmoid(acc_t x) {
    // Example: direct logistic approach
    // Danger: 'exp' usage in some HLS flows may need approximations
    // or a piecewise approach. For small 3x3, it's often fine:
#pragma HLS RESOURCE variable=x core=FAddSub_nodsp
    double xd = (double)x;
    double ret = 1.0 / (1.0 + std::exp(-xd));
    return (acc_t)ret;
}

// A small polynomial approximation for e^x
acc_t exp_fixed(acc_t x) {
    // Clip to avoid large overflows
    if (x > (acc_t)6.0)  x = (acc_t)6.0;
    if (x < (acc_t)-6.0) x = (acc_t)-6.0;

    acc_t result = ONE + x
                 + (x * x) / TWO
                 + (x * x * x) / SIX
                 + (x * x * x * x) / TWELVE;
    return (result > ZERO) ? result : ZERO;
}

// Softmax on a 1D array of length N*N or just N if you prefer row-wise
// Here, we do it on the entire 3x3 = 9 elements to keep it simple.
void softmax(acc_t *arr) {
    // sum of e^arr[i]
    acc_t sum_exp = ZERO;
    for (int i = 0; i < N*N; i++) {
        acc_t tmp = exp_fixed(arr[i]);
        arr[i] = tmp;
        sum_exp += tmp;
    }
    // normalize
    if (sum_exp > ZERO) {
        for (int i = 0; i < N*N; i++) {
            arr[i] = arr[i] / sum_exp;
        }
    }
}

//=======================================
// Systolic Array Implementation
//=======================================
void systolic_array(
    bool rst,
    bool start,
    data_t A[N*N],
    data_t B[N*N],
    acc_t C[N*N],
    bool &done,
    systolic_state_t &state,
    opcode_t opcode
) {
#pragma HLS PIPELINE II=1

    //----------------------------------
    // RESET
    //----------------------------------
    if (rst) {
        state.state = IDLE;
        state.k = 0;
        state.busy = false;
        done = false;
        // Clear partial_sum and C
        for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
            state.partial_sum[i] = ZERO;
            C[i] = ZERO;
        }
        return;
    }

    //----------------------------------
    // FSM
    //----------------------------------
    switch (state.state) {

    //----------------------------------
    // IDLE STATE
    //----------------------------------
    case IDLE:
        done = false;
        // If we get start=1 and not busy, check opcode
        if (start && !state.busy) {
            state.busy = true;
            // For matrix multiply, we'll go to CALC only if opcode == 0x1
            // Otherwise we skip to FINISH to do the immediate operation.
            if (opcode == 0x1) {
                state.state = CALC;  
                state.k = 0;
                for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                    state.partial_sum[i] = ZERO;
                }
            } else {
                // No matrix multiply needed; jump directly to FINISH
                state.state = FINISH;
            }
        }
        break;

    //----------------------------------
    // CALC STATE
    //----------------------------------
    case CALC:
        // We do one stage of 3x3 multiply per iteration
        if (state.k < N) {
            for (int i = 0; i < N; i++) {
#pragma HLS UNROLL
                for (int j = 0; j < N; j++) {
#pragma HLS UNROLL
                    state.partial_sum[i*N + j] +=
                            (acc_t)A[i*N + state.k] * (acc_t)B[state.k*N + j];
                }
            }
            state.k++;
            if (state.k == N) {
                state.state = FINISH;
            }
        }
        break;

    //----------------------------------
    // FINISH STATE
    //----------------------------------
    case FINISH:
        // Start with partial_sum
        for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
            C[i] = state.partial_sum[i];
        }

        //--------------------------------
        // CHECK OPCODE
        //--------------------------------
        switch (opcode) {
        case 0x0: // No-Op
            // Do nothing
            break;

        case 0x1: // 3x3 Systolic Multiply was done in CALC
            // Already in C
            break;

        case 0x2: // ReLU
            for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = relu(C[i]);
            }
            break;

        case 0x3: // Leaky ReLU
            for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = leaky_relu(C[i]);
            }
            break;

        case 0x4: // Softmax
            softmax(C);
            break;

        case 0x8: // Min Pooling
        {
            acc_t min_val = C[0];
            for (int i = 1; i < N*N; i++) {
#pragma HLS UNROLL
                if (C[i] < min_val) {
                    min_val = C[i];
                }
            }
            // Put min in C[0], zero out others
            C[0] = min_val;
            for (int i = 1; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = ZERO;
            }
            break;
        }

        case 0x9: // Stochastic Gradient Descent
        {
            // C = A - LR * B
            // But note that we actually stored partial_sum = A×B if we did a multiply.
            // For pure SGD, you might want to interpret
            // A as "params", B as "grads" from the outside, ignoring the multiply.
            for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = (acc_t)A[i] - LR * (acc_t)B[i];
            }
            break;
        }

        case 0xA: // Sigmoid
            for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = sigmoid(C[i]);
            }
            break;

        case 0xB: // Compute Loss (MSE)
        {
            acc_t loss = ZERO;
            for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                acc_t diff = (acc_t)A[i] - (acc_t)B[i];
                loss += diff * diff;
            }
            loss /= (acc_t)(N*N);
            C[0] = loss;
            for (int i = 1; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = ZERO;
            }
            break;
        }

        case 0xC: // Average Pooling
        {
            acc_t sum_val = ZERO;
            for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                sum_val += C[i];
            }
            acc_t avg_val = sum_val / (acc_t)(N*N);
            C[0] = avg_val;
            for (int i = 1; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = ZERO;
            }
            break;
        }

        case 0xE: // Max Pooling
        {
            acc_t max_val = C[0];
            for (int i = 1; i < N*N; i++) {
#pragma HLS UNROLL
                if (C[i] > max_val) {
                    max_val = C[i];
                }
            }
            C[0] = max_val;
            for (int i = 1; i < N*N; i++) {
#pragma HLS UNROLL
                C[i] = ZERO;
            }
            break;
        }

        default:
            // Unhandled or placeholder for extended opcodes
            break;
        }

        // Done
        done = true;
        state.busy = false;
        state.state = IDLE;
        break;
    }
}

//=======================================
// Top-Level For Multiple Arrays
//=======================================
void top_systolic_controller_flat(
    bool rst,
    bool start,
    opcode_t opcode,
    data_t flat_A[NUM_ARRAYS * N * N],
    data_t flat_B[NUM_ARRAYS * N * N],
    acc_t flat_C[NUM_ARRAYS * N * N],
    bool done[NUM_ARRAYS]
) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS ARRAY_PARTITION variable=flat_A complete dim=1
#pragma HLS ARRAY_PARTITION variable=flat_B complete dim=1
#pragma HLS ARRAY_PARTITION variable=flat_C complete dim=1
#pragma HLS ARRAY_PARTITION variable=done   complete dim=1

    static systolic_state_t states[NUM_ARRAYS];
#pragma HLS ARRAY_PARTITION variable=states complete dim=1

    for (int m = 0; m < NUM_ARRAYS; m++) {
#pragma HLS UNROLL
        systolic_array(
            rst,
            start,
            &flat_A[m * N * N],
            &flat_B[m * N * N],
            &flat_C[m * N * N],
            done[m],
            states[m],
            opcode
        );
    }
}
