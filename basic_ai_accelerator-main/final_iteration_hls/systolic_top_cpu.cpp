#include "systolic_top_cpu.h"
#include <hls_stream.h>
#include <iostream>

// ==================================================
// We reuse your definitions from systolic_controller.h:
//   - data_t, acc_t
//   - N=3, NUM_ARRAYS=4
//   - opcode_t
//   - systolic_array(...)
//
// We'll replicate "top_systolic_controller_flat" logic here
// so we can track 'busy' and 'done' in a single place.
// ==================================================

// We'll store the state for each systolic array:
static systolic_state_t states[NUM_ARRAYS];

// Flattened A, B, C:
static data_t A[NUM_ARRAYS * N * N];
static data_t B[NUM_ARRAYS * N * N];
static acc_t  C[NUM_ARRAYS * N * N];
static bool   done_array[NUM_ARRAYS];

//-------------------------------------------
// Helper: Convert 4 bool opcode bits to a single 4-bit integer
//-------------------------------------------
inline opcode_t pack_opcode(bool b0, bool b1, bool b2, bool b3) {
#pragma HLS INLINE
    // Suppose b3 is the MSB, b0 is the LSB. Adjust if you like the reverse.
    opcode_t result = 0;
    result |= (b0 ? 1 : 0) << 0;
    result |= (b1 ? 1 : 0) << 1;
    result |= (b2 ? 1 : 0) << 2;
    result |= (b3 ? 1 : 0) << 3;
    return result;
}

//-------------------------------------------------------------
// The top-level CPU-style function
//-------------------------------------------------------------
void systolic_top_cpu(
    bool opcode_in0,
    bool opcode_in1,
    bool opcode_in2,
    bool opcode_in3,
    bool start_in,
    bool stop_in,
    bool clk_in,
    bool rst_in,

    bool &done_out,
    bool &busy_out,
    bool &out3,
    bool &out4,
    bool &out5,
    bool &out6,
    bool &out7,
    bool &out8,

    ap_uint<8> &uart_data_inout
)
{
#pragma HLS INTERFACE ap_none port=opcode_in0
#pragma HLS INTERFACE ap_none port=opcode_in1
#pragma HLS INTERFACE ap_none port=opcode_in2
#pragma HLS INTERFACE ap_none port=opcode_in3
#pragma HLS INTERFACE ap_none port=start_in
#pragma HLS INTERFACE ap_none port=stop_in
#pragma HLS INTERFACE ap_none port=clk_in
#pragma HLS INTERFACE ap_none port=rst_in

#pragma HLS INTERFACE ap_none port=done_out
#pragma HLS INTERFACE ap_none port=busy_out
#pragma HLS INTERFACE ap_none port=out3
#pragma HLS INTERFACE ap_none port=out4
#pragma HLS INTERFACE ap_none port=out5
#pragma HLS INTERFACE ap_none port=out6
#pragma HLS INTERFACE ap_none port=out7
#pragma HLS INTERFACE ap_none port=out8

#pragma HLS INTERFACE ap_none port=uart_data_inout

#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS PIPELINE II=1

    // 1) Pack the opcode
    opcode_t opcode = pack_opcode(opcode_in0, opcode_in1, opcode_in2, opcode_in3);

    // 2) If reset, clear everything
    if (rst_in) {
        for (int m = 0; m < NUM_ARRAYS; m++) {
#pragma HLS UNROLL
            states[m].state = IDLE;
            states[m].busy = false;
            states[m].k = 0;
            done_array[m] = false;
            for (int i = 0; i < N*N; i++) {
#pragma HLS UNROLL
                states[m].partial_sum[i] = (acc_t)0;
                A[m*N*N + i] = (data_t)0;
                B[m*N*N + i] = (data_t)0;
                C[m*N*N + i] = (acc_t)0;
            }
        }
        // done_out = false;  // We'll set it below
        // busy_out = false;
    }

    // 3) If start_in is high, we might read from the 8-bit UART:
    //    For example, read 9*(NUM_ARRAYS) for A, then B. 
    //    (Here we only show a naive example to illustrate.)
    if (start_in) {
        for (int i = 0; i < (N*N*NUM_ARRAYS); i++) {
#pragma HLS PIPELINE
            // In a real design, you'd have a handshake or wait for data to be valid.
            // This just demonstrates a single read each cycle:
            A[i] = (data_t)uart_data_inout;
        }
        for (int i = 0; i < (N*N*NUM_ARRAYS); i++) {
#pragma HLS PIPELINE
            B[i] = (data_t)uart_data_inout;
        }
    }

    // 4) Call the systolic_array for each of the 4 “parallel arrays”
    //    This is basically "top_systolic_controller_flat" inlined here,
    //    so we can track states[m].busy for "busy_out".
    for (int m = 0; m < NUM_ARRAYS; m++) {
#pragma HLS UNROLL
        systolic_array(
            /*rst=*/rst_in,
            /*start=*/start_in,
            &A[m*N*N],
            &B[m*N*N],
            &C[m*N*N],
            done_array[m],
            states[m],
            opcode
        );
    }

    // 5) Combine the done signals
    bool all_done = true;
    bool any_busy = false;
    for (int m = 0; m < NUM_ARRAYS; m++) {
#pragma HLS UNROLL
        all_done &= done_array[m];
        any_busy |= states[m].busy; // if any array is busy, we set busy_out
    }

    // 6) Set outputs
    done_out = all_done;
    busy_out = any_busy;

    // The rest of out pins are placeholders (you said you don’t need them).
    out3 = false;
    out4 = false;
    out5 = false;
    out6 = false;
    out7 = false;
    out8 = false;

    // 7) If everything is done and user hasn't stopped yet, maybe output C
    if (all_done && !stop_in) {
        // Example: push out C[0] on the bus. 
        // Real design would iterate to send all 36 or 9 values, etc.
        uart_data_inout = (ap_uint<8>)(C[0]);
    }
}
