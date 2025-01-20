set moduleName systolic_top_uart_4parallel
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type function
set FunctionProtocol ap_ctrl_none
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 2
set C_modelName {systolic_top_uart_4parallel}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ opcode_in0 uint 1 regular  }
	{ opcode_in1 uint 1 regular  }
	{ opcode_in2 uint 1 regular  }
	{ opcode_in3 uint 1 regular  }
	{ start_in uint 1 regular  }
	{ tx_in uint 1 regular  }
	{ clk_in uint 1 unused  }
	{ rst_in uint 1 regular  }
	{ done_out int 1 regular {pointer 1}  }
	{ busy_out int 1 regular {pointer 1}  }
	{ rx_out int 1 regular {pointer 1}  }
	{ out4 int 1 regular {pointer 1}  }
	{ out5 int 1 regular {pointer 1}  }
	{ out6 int 1 regular {pointer 1}  }
	{ out7 int 1 regular {pointer 1}  }
	{ out8 int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "opcode_in0", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "opcode_in1", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "opcode_in2", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "opcode_in3", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "start_in", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "tx_in", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "clk_in", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "rst_in", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "done_out", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "busy_out", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "rx_out", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out4", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out5", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out6", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out7", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "out8", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 18
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ opcode_in0 sc_in sc_lv 1 signal 0 } 
	{ opcode_in1 sc_in sc_lv 1 signal 1 } 
	{ opcode_in2 sc_in sc_lv 1 signal 2 } 
	{ opcode_in3 sc_in sc_lv 1 signal 3 } 
	{ start_in sc_in sc_lv 1 signal 4 } 
	{ tx_in sc_in sc_lv 1 signal 5 } 
	{ clk_in sc_in sc_lv 1 signal 6 } 
	{ rst_in sc_in sc_lv 1 signal 7 } 
	{ done_out sc_out sc_lv 1 signal 8 } 
	{ busy_out sc_out sc_lv 1 signal 9 } 
	{ rx_out sc_out sc_lv 1 signal 10 } 
	{ out4 sc_out sc_lv 1 signal 11 } 
	{ out5 sc_out sc_lv 1 signal 12 } 
	{ out6 sc_out sc_lv 1 signal 13 } 
	{ out7 sc_out sc_lv 1 signal 14 } 
	{ out8 sc_out sc_lv 1 signal 15 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "opcode_in0", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "opcode_in0", "role": "default" }} , 
 	{ "name": "opcode_in1", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "opcode_in1", "role": "default" }} , 
 	{ "name": "opcode_in2", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "opcode_in2", "role": "default" }} , 
 	{ "name": "opcode_in3", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "opcode_in3", "role": "default" }} , 
 	{ "name": "start_in", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "start_in", "role": "default" }} , 
 	{ "name": "tx_in", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "tx_in", "role": "default" }} , 
 	{ "name": "clk_in", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "clk_in", "role": "default" }} , 
 	{ "name": "rst_in", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "rst_in", "role": "default" }} , 
 	{ "name": "done_out", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "done_out", "role": "default" }} , 
 	{ "name": "busy_out", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "busy_out", "role": "default" }} , 
 	{ "name": "rx_out", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "rx_out", "role": "default" }} , 
 	{ "name": "out4", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "out4", "role": "default" }} , 
 	{ "name": "out5", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "out5", "role": "default" }} , 
 	{ "name": "out6", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "out6", "role": "default" }} , 
 	{ "name": "out7", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "out7", "role": "default" }} , 
 	{ "name": "out8", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "out8", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"],
		"CDFG" : "systolic_top_uart_4parallel",
		"Protocol" : "ap_ctrl_none",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "0", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "1", "EstimateLatencyMin" : "1", "EstimateLatencyMax" : "1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "opcode_in0", "Type" : "None", "Direction" : "I"},
			{"Name" : "opcode_in1", "Type" : "None", "Direction" : "I"},
			{"Name" : "opcode_in2", "Type" : "None", "Direction" : "I"},
			{"Name" : "opcode_in3", "Type" : "None", "Direction" : "I"},
			{"Name" : "start_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "tx_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "clk_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "rst_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "done_out", "Type" : "None", "Direction" : "O"},
			{"Name" : "busy_out", "Type" : "None", "Direction" : "O"},
			{"Name" : "rx_out", "Type" : "None", "Direction" : "O"},
			{"Name" : "out4", "Type" : "None", "Direction" : "O"},
			{"Name" : "out5", "Type" : "None", "Direction" : "O"},
			{"Name" : "out6", "Type" : "None", "Direction" : "O"},
			{"Name" : "out7", "Type" : "None", "Direction" : "O"},
			{"Name" : "out8", "Type" : "None", "Direction" : "O"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_47", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_46", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_45", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_44", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_43", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_42", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_41", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_40", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_51", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_50", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_49", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_48", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_71", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_67", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_66", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_65", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_64", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_63", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_62", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_70", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_69", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_68", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_10", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_11", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_12", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_13", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_14", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_15", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_16", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_17", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_18", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_19", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_20", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_21", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_22", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_23", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_24", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_25", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_26", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_61", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_60", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_59", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_58", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_57", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_56", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_55", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_54", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_53", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_52", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_10", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_11", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_12", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_13", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_14", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_15", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_16", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_17", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_18", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_19", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_20", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_21", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_22", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_23", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_24", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_25", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_26", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_27", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_28", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_29", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_30", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_31", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_32", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_33", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_34", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_35", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "rx_st_active", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "rx_st_bitcount", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "rx_st_sample_count", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "rx_st_shift_reg", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "rx_data", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "load_count", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "send_count", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_3", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_39", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_38", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_37", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_36", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_35", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_34", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_33", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_32", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_31", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_30", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_29", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_28", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_27", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_26", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_25", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_24", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_23", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_22", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_21", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_20", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_19", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_18", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_17", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_16", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_15", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_14", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_13", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_12", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_11", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_10", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_9", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_8", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_7", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_6", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_5", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_4", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_27", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_28", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_29", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_30", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_31", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_32", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_33", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_34", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_35", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "fsm_state", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "internal_busy", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "internal_done", "Type" : "OVld", "Direction" : "IO"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U1", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U2", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U3", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U4", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U5", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U6", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U7", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U8", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U9", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U10", "Parent" : "0"},
	{"ID" : "11", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U11", "Parent" : "0"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U12", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U13", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U14", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U15", "Parent" : "0"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U16", "Parent" : "0"},
	{"ID" : "17", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U17", "Parent" : "0"},
	{"ID" : "18", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U18", "Parent" : "0"},
	{"ID" : "19", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U19", "Parent" : "0"},
	{"ID" : "20", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U20", "Parent" : "0"},
	{"ID" : "21", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U21", "Parent" : "0"},
	{"ID" : "22", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U22", "Parent" : "0"},
	{"ID" : "23", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U23", "Parent" : "0"},
	{"ID" : "24", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U24", "Parent" : "0"},
	{"ID" : "25", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U25", "Parent" : "0"},
	{"ID" : "26", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U26", "Parent" : "0"},
	{"ID" : "27", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U27", "Parent" : "0"},
	{"ID" : "28", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U28", "Parent" : "0"},
	{"ID" : "29", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U29", "Parent" : "0"},
	{"ID" : "30", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U30", "Parent" : "0"},
	{"ID" : "31", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U31", "Parent" : "0"},
	{"ID" : "32", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U32", "Parent" : "0"},
	{"ID" : "33", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U33", "Parent" : "0"},
	{"ID" : "34", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U34", "Parent" : "0"},
	{"ID" : "35", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U35", "Parent" : "0"},
	{"ID" : "36", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_28s_28s_52_1_1_U36", "Parent" : "0"},
	{"ID" : "37", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_7_4_32_1_1_U37", "Parent" : "0"},
	{"ID" : "38", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_7_4_32_1_1_U38", "Parent" : "0"},
	{"ID" : "39", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_7_4_32_1_1_U39", "Parent" : "0"},
	{"ID" : "40", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_7_4_32_1_1_U40", "Parent" : "0"},
	{"ID" : "41", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_13_4_32_1_1_U41", "Parent" : "0"},
	{"ID" : "42", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_19_4_32_1_1_U42", "Parent" : "0"},
	{"ID" : "43", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_25_5_32_1_1_U43", "Parent" : "0"},
	{"ID" : "44", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U44", "Parent" : "0"},
	{"ID" : "45", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U45", "Parent" : "0"},
	{"ID" : "46", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U46", "Parent" : "0"},
	{"ID" : "47", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_31_5_32_1_1_U47", "Parent" : "0"},
	{"ID" : "48", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_37_5_32_1_1_U48", "Parent" : "0"},
	{"ID" : "49", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_43_6_32_1_1_U49", "Parent" : "0"},
	{"ID" : "50", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U50", "Parent" : "0"},
	{"ID" : "51", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U51", "Parent" : "0"},
	{"ID" : "52", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U52", "Parent" : "0"},
	{"ID" : "53", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_49_6_32_1_1_U53", "Parent" : "0"},
	{"ID" : "54", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_55_6_32_1_1_U54", "Parent" : "0"},
	{"ID" : "55", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_61_6_32_1_1_U55", "Parent" : "0"},
	{"ID" : "56", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U56", "Parent" : "0"},
	{"ID" : "57", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U57", "Parent" : "0"},
	{"ID" : "58", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U58", "Parent" : "0"},
	{"ID" : "59", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_67_6_32_1_1_U59", "Parent" : "0"},
	{"ID" : "60", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_73_6_32_1_1_U60", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	systolic_top_uart_4parallel {
		opcode_in0 {Type I LastRead 0 FirstWrite -1}
		opcode_in1 {Type I LastRead 0 FirstWrite -1}
		opcode_in2 {Type I LastRead 0 FirstWrite -1}
		opcode_in3 {Type I LastRead 0 FirstWrite -1}
		start_in {Type I LastRead 0 FirstWrite -1}
		tx_in {Type I LastRead 0 FirstWrite -1}
		clk_in {Type I LastRead -1 FirstWrite -1}
		rst_in {Type I LastRead 0 FirstWrite -1}
		done_out {Type O LastRead -1 FirstWrite 1}
		busy_out {Type O LastRead -1 FirstWrite 1}
		rx_out {Type O LastRead -1 FirstWrite 1}
		out4 {Type O LastRead -1 FirstWrite 1}
		out5 {Type O LastRead -1 FirstWrite 1}
		out6 {Type O LastRead -1 FirstWrite 1}
		out7 {Type O LastRead -1 FirstWrite 1}
		out8 {Type O LastRead -1 FirstWrite 1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_47 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_46 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_45 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_44 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_43 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_42 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_41 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_40 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_51 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_50 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_49 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_48 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_71 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_67 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_66 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_65 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_64 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_63 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_62 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_70 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_69 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_68 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_11 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_12 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_13 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_14 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_15 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_16 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_17 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_18 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_19 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_21 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_22 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_23 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_24 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_25 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_26 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_61 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_60 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_59 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_58 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_57 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_56 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_55 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_54 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_53 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_52 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_10 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_11 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_12 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_13 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_14 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_15 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_16 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_17 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_18 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_19 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_20 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_21 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_22 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_23 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_24 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_25 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_26 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_27 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_28 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_29 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_30 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_31 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_32 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_33 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_34 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1B_35 {Type IO LastRead -1 FirstWrite -1}
		rx_st_active {Type IO LastRead -1 FirstWrite -1}
		rx_st_bitcount {Type IO LastRead -1 FirstWrite -1}
		rx_st_sample_count {Type IO LastRead -1 FirstWrite -1}
		rx_st_shift_reg {Type IO LastRead -1 FirstWrite -1}
		rx_data {Type IO LastRead -1 FirstWrite -1}
		load_count {Type IO LastRead -1 FirstWrite -1}
		send_count {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_3 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_2 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_1 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_39 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_38 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_37 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_36 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_35 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_34 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_33 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_32 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_31 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_30 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_29 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_28 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_27 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_26 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_25 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_24 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_23 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_22 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_21 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_20 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_19 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_18 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_17 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_16 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_15 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_14 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_13 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_12 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_11 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_10 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_9 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_8 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_7 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_6 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_5 {Type IO LastRead -1 FirstWrite -1}
		systolic_top_uart_4parallel_bool_bool_bool_bool_bool_bool_bool_bool_bool_4 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_27 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_28 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_29 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_30 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_31 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_32 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_33 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_34 {Type IO LastRead -1 FirstWrite -1}
		p_ZZ27systolic_top_uart_4parallelbbbbbbbbRbS_S_S_S_S_S_S_E1A_35 {Type IO LastRead -1 FirstWrite -1}
		fsm_state {Type IO LastRead -1 FirstWrite -1}
		internal_busy {Type IO LastRead -1 FirstWrite -1}
		internal_done {Type IO LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	opcode_in0 { ap_none {  { opcode_in0 in_data 0 1 } } }
	opcode_in1 { ap_none {  { opcode_in1 in_data 0 1 } } }
	opcode_in2 { ap_none {  { opcode_in2 in_data 0 1 } } }
	opcode_in3 { ap_none {  { opcode_in3 in_data 0 1 } } }
	start_in { ap_none {  { start_in in_data 0 1 } } }
	tx_in { ap_none {  { tx_in in_data 0 1 } } }
	clk_in { ap_none {  { clk_in in_data 0 1 } } }
	rst_in { ap_none {  { rst_in in_data 0 1 } } }
	done_out { ap_none {  { done_out out_data 1 1 } } }
	busy_out { ap_none {  { busy_out out_data 1 1 } } }
	rx_out { ap_none {  { rx_out out_data 1 1 } } }
	out4 { ap_none {  { out4 out_data 1 1 } } }
	out5 { ap_none {  { out5 out_data 1 1 } } }
	out6 { ap_none {  { out6 out_data 1 1 } } }
	out7 { ap_none {  { out7 out_data 1 1 } } }
	out8 { ap_none {  { out8 out_data 1 1 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
