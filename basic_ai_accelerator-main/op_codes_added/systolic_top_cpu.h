#ifndef SYSTOLIC_TOP_CPU_H
#define SYSTOLIC_TOP_CPU_H

#include <ap_int.h>
#include "systolic_controller.h"

// A wrapper around your systolic design that exposes
// 8 input pins, 8 output pins, and an 8-bit in/out bus.

void systolic_top_cpu(
    //=====================
    // 8 INPUT PINS
    //=====================
    bool opcode_in0,
    bool opcode_in1,
    bool opcode_in2,
    bool opcode_in3,
    bool start_in,
    bool stop_in,
    bool clk_in,
    bool rst_in,

    //=====================
    // 8 OUTPUT PINS
    //  (We only use 'done_out' and 'busy_out' realistically;
    //   the rest are placeholders.)
    //=====================
    bool &done_out,
    bool &busy_out,
    bool &out3,
    bool &out4,
    bool &out5,
    bool &out6,
    bool &out7,
    bool &out8,

    //=====================
    // 8 In/Out pins (Parallel UART)
    //=====================
    ap_uint<8> &uart_data_inout
);

#endif // SYSTOLIC_TOP_CPU_H
