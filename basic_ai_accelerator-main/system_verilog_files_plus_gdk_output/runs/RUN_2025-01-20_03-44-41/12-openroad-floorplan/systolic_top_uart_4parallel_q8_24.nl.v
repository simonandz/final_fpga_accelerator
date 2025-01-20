module systolic_top_uart_4parallel_q8_24 (busy_out,
    clk_in,
    done_out,
    opcode_in0,
    opcode_in1,
    opcode_in2,
    opcode_in3,
    out4,
    out5,
    out6,
    out7,
    out8,
    rst_in,
    rx_out,
    start_in,
    tx_in);
 output busy_out;
 input clk_in;
 output done_out;
 input opcode_in0;
 input opcode_in1;
 input opcode_in2;
 input opcode_in3;
 output out4;
 output out5;
 output out6;
 output out7;
 output out8;
 input rst_in;
 output rx_out;
 input start_in;
 input tx_in;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire \fsm_state[0] ;
 wire internal_busy;
 wire zero_;

 sky130_fd_sc_hd__inv_2 _05_ (.A(rst_in),
    .Y(_01_));
 sky130_fd_sc_hd__a21o_2 _06_ (.A1(\fsm_state[0] ),
    .A2(start_in),
    .B1(internal_busy),
    .X(_04_));
 sky130_fd_sc_hd__and2b_2 _07_ (.A_N(start_in),
    .B(\fsm_state[0] ),
    .X(_00_));
 sky130_fd_sc_hd__inv_2 _08_ (.A(rst_in),
    .Y(_02_));
 sky130_fd_sc_hd__inv_2 _09_ (.A(rst_in),
    .Y(_03_));
 sky130_fd_sc_hd__dfstp_2 _10_ (.CLK(clk_in),
    .D(_00_),
    .SET_B(_01_),
    .Q(\fsm_state[0] ));
 sky130_fd_sc_hd__dfrtp_2 _11_ (.CLK(clk_in),
    .D(internal_busy),
    .RESET_B(_02_),
    .Q(busy_out));
 sky130_fd_sc_hd__dfrtp_2 _12_ (.CLK(clk_in),
    .D(_04_),
    .RESET_B(_03_),
    .Q(internal_busy));
 sky130_fd_sc_hd__buf_2 _13_ (.A(zero_),
    .X(done_out));
 sky130_fd_sc_hd__buf_2 _14_ (.A(zero_),
    .X(out4));
 sky130_fd_sc_hd__buf_2 _15_ (.A(zero_),
    .X(out5));
 sky130_fd_sc_hd__buf_2 _16_ (.A(zero_),
    .X(out6));
 sky130_fd_sc_hd__buf_2 _17_ (.A(zero_),
    .X(out7));
 sky130_fd_sc_hd__buf_2 _18_ (.A(zero_),
    .X(out8));
 sky130_fd_sc_hd__buf_2 _19_ (.A(zero_),
    .X(rx_out));
 sky130_fd_sc_hd__conb_1 TIE_ZERO_zero_ (.LO(zero_));
endmodule
