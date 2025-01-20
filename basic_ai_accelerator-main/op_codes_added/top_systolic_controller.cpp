#include "systolic_controller.h"

void top_systolic_controller_flat(
    bool rst,
    bool start,
    opcode_t opcode,
    data_t flat_A[NUM_ARRAYS * N * N],
    data_t flat_B[NUM_ARRAYS * N * N],
    acc_t flat_C[NUM_ARRAYS * N * N],
    bool done[NUM_ARRAYS]
) {
    // HLS INTERFACE Directives
    #pragma HLS INTERFACE ap_ctrl_none port=return
    #pragma HLS ARRAY_PARTITION variable=flat_A complete dim=1
    #pragma HLS ARRAY_PARTITION variable=flat_B complete dim=1
    #pragma HLS ARRAY_PARTITION variable=flat_C complete dim=1
    #pragma HLS ARRAY_PARTITION variable=done complete dim=1

    // Instantiate Systolic Arrays
    systolic_state_t states[NUM_ARRAYS];
    #pragma HLS ARRAY_PARTITION variable=states complete dim=1

    for(int m = 0; m < NUM_ARRAYS; m++) {
        #pragma HLS UNROLL
        systolic_array(
            rst,
            start,
            &flat_A[m*N*N],
            &flat_B[m*N*N],
            &flat_C[m*N*N],
            done[m],
            states[m],
            opcode // Pass the Opcode to Each Systolic Array
        );
    }
}
