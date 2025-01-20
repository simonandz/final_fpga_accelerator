#include "systolic_controller.h"
#include <cmath> // For fabs

// Define Constants with Fixed-Point Precision
const acc_t ZERO = (acc_t)0.0;
const acc_t ONE = (acc_t)1.0;
const acc_t TWO = (acc_t)2.0;
const acc_t SIX = (acc_t)6.0;
const acc_t TWELVE = (acc_t)12.0; // Added TWELVE
const acc_t ALPHA = (acc_t)0.1;   // For Leaky ReLU

// ReLU Activation Function
acc_t relu(acc_t x) {
    acc_t result;
    if (x > ZERO) {
        result = x;
    } else {
        result = ZERO;
    }
    // Temporary Debug Print (Only for Simulation)
    #ifndef __SYNTHESIS__
    std::cout << "ReLU: Input = " << x << ", Output = " << result << std::endl;
    #endif
    return result;
}

// Leaky ReLU Activation Function
acc_t leaky_relu(acc_t x) {
    acc_t result;
    if (x > ZERO) {
        result = x;
    } else {
        result = x * ALPHA;
    }
    // Temporary Debug Print (Only for Simulation)
    #ifndef __SYNTHESIS__
    std::cout << "Leaky ReLU: Input = " << x << ", Output = " << result << std::endl;
    #endif
    return result;
}

// Sigmoid Activation Function
acc_t sigmoid(acc_t x) {
    // Enhanced Piecewise Linear Approximation
    if (x < -3.0) return (acc_t)0.0;
    else if (x < -2.0) return (acc_t)0.05;
    else if (x < -1.0) return (acc_t)0.12;
    else if (x < 0.0) return (acc_t)0.27;
    else if (x < 1.0) return (acc_t)0.73;
    else if (x < 2.0) return (acc_t)0.88;
    else if (x < 3.0) return (acc_t)0.95;
    else return (acc_t)1.0;
}

// Exponential Function for Softmax
acc_t exp_fixed(acc_t x) {
    // Clamp x to Prevent Overflow/Underflow
    if(x > 6.0) x = 6.0;
    if(x < -6.0) x = -6.0;

    // Improved Exponential Approximation Using 4th-Order Taylor Series
    acc_t result = ONE + x + (x * x) / TWO + (x * x * x) / SIX + (x * x * x * x) / TWELVE;
    return (result > ZERO) ? result : ZERO; // Ensure Positivity
}

// Softmax Function
void softmax(acc_t* row, acc_t* output) {
    acc_t sum = ZERO;
    // Compute Exponentials and Sum
    for(int i = 0; i < N; i++) {
        output[i] = exp_fixed(row[i]);
        sum += output[i];
        // Temporary Debug Print (Only for Simulation)
        #ifndef __SYNTHESIS__
        std::cout << "Softmax: row[" << i << "] = " << row[i] << ", exp = " << output[i] << std::endl;
        #endif
    }
    // Normalize
    for(int i = 0; i < N; i++) {
        output[i] = output[i] / sum;
        // Temporary Debug Print (Only for Simulation)
        #ifndef __SYNTHESIS__
        std::cout << "Softmax: output[" << i << "] = " << output[i] << std::endl;
        #endif
    }
}

// Systolic Array Function
void systolic_array(
    bool rst,
    bool start,
    data_t A[N*N],
    data_t B[N*N],
    acc_t C[N*N],
    bool &done,
    systolic_state_t &state,
    opcode_t opcode // Opcode Input
) {
    // HLS PIPELINE Directive for Initiating Pipelining with Initiation Interval = 1
    #pragma HLS PIPELINE II=1

    if (rst) {
        state.state = IDLE;
        state.k = 0;
        state.busy = false;
        done = false;
        // Clear Partial Sums and C
        for(int i = 0; i < N*N; i++) {
            #pragma HLS UNROLL
            state.partial_sum[i] = 0;
            C[i] = 0;
        }
    }
    else {
        switch(state.state) {
            case IDLE:
                done = false;
                if (start && !state.busy) {
                    state.state = CALC;
                    state.busy  = true;
                    state.k     = 0;
                    // Initialize Partial Sums
                    for(int i = 0; i < N*N; i++) {
                        #pragma HLS UNROLL
                        state.partial_sum[i] = 0;
                    }
                }
                break;

            case CALC:
                if (state.k < N) {
                    // Perform Multiplication and Accumulation
                    for(int i = 0; i < N; i++) {
                        #pragma HLS UNROLL
                        for(int j = 0; j < N; j++) {
                            #pragma HLS UNROLL
                            // Accumulate in Higher Precision
                            state.partial_sum[i*N + j] += static_cast<acc_t>(A[i*N + state.k]) * static_cast<acc_t>(B[state.k*N + j]);
                        }
                    }
                    state.k++;
                    if (state.k == N) {
                        state.state = FINISH;
                    }
                }
                break;

            case FINISH:
                // Assign the Computed Partial Sums to Output C
                for(int i = 0; i < N*N; i++) {
                    #pragma HLS UNROLL
                    C[i] = state.partial_sum[i];
                }

                // Apply Activation Functions Based on Opcode
                switch(opcode) {
                    case 0x0: { // No Op
                        // Do Nothing
                        break;
                    }
                    case 0x1: { // Multiplication Only
                        // Do Nothing Additional
                        break;
                    }
                    case 0x2: { // ReLU
                        for(int i = 0; i < N*N; i++) {
                            #pragma HLS UNROLL
                            C[i] = relu(C[i]);
                        }
                        break;
                    }
                    case 0xC: { // Leaky ReLU
                        for(int i = 0; i < N*N; i++) {
                            #pragma HLS UNROLL
                            C[i] = leaky_relu(C[i]);
                        }
                        break;
                    }
                    case 0x8: { // Softmax
                        // Apply Softmax Row-Wise for Each Systolic Array
                        for(int m = 0; m < NUM_ARRAYS; m++) {
                            #pragma HLS UNROLL
                            softmax(&C[m*N*N], &C[m*N*N]); // Assuming Row-Wise for Each Array
                        }
                        break;
                    }
                    case 0xA: { // Sigmoid
                        for(int i = 0; i < N*N; i++) {
                            #pragma HLS UNROLL
                            C[i] = sigmoid(C[i]);
                        }
                        break;
                    }
                    default: { // Undefined Opcode
                        // Do Nothing
                        break;
                    }
                }

                done = true;
                state.busy = false;
                state.state = IDLE;
                break;
        }
    }
}
