#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst", 1, hls_in, -1, "", "", 1),
	Port_Property("opcode_in0", 1, hls_in, 0, "ap_none", "in_data", 1),
	Port_Property("opcode_in1", 1, hls_in, 1, "ap_none", "in_data", 1),
	Port_Property("opcode_in2", 1, hls_in, 2, "ap_none", "in_data", 1),
	Port_Property("opcode_in3", 1, hls_in, 3, "ap_none", "in_data", 1),
	Port_Property("start_in", 1, hls_in, 4, "ap_none", "in_data", 1),
	Port_Property("tx_in", 1, hls_in, 5, "ap_none", "in_data", 1),
	Port_Property("clk_in", 1, hls_in, 6, "ap_none", "in_data", 1),
	Port_Property("rst_in", 1, hls_in, 7, "ap_none", "in_data", 1),
	Port_Property("done_out", 1, hls_out, 8, "ap_none", "out_data", 1),
	Port_Property("busy_out", 1, hls_out, 9, "ap_none", "out_data", 1),
	Port_Property("rx_out", 1, hls_out, 10, "ap_none", "out_data", 1),
	Port_Property("out4", 1, hls_out, 11, "ap_none", "out_data", 1),
	Port_Property("out5", 1, hls_out, 12, "ap_none", "out_data", 1),
	Port_Property("out6", 1, hls_out, 13, "ap_none", "out_data", 1),
	Port_Property("out7", 1, hls_out, 14, "ap_none", "out_data", 1),
	Port_Property("out8", 1, hls_out, 15, "ap_none", "out_data", 1),
};
const char* HLS_Design_Meta::dut_name = "systolic_top_uart_4parallel";
