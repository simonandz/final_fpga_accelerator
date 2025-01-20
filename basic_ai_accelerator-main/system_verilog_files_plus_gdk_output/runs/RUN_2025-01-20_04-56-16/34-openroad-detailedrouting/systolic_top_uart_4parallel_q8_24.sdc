###############################################################################
# Created by write_sdc
###############################################################################
current_design systolic_top_uart_4parallel_q8_24
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 20.0000 
set_clock_uncertainty 0.2500 clk
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {clk_in}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {opcode_in0}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {opcode_in1}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {opcode_in2}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {opcode_in3}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rst_in}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {start_in}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {tx_in}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {busy_out}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {done_out}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {out4}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {out5}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {out6}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {out7}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {out8}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rx_out}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {busy_out}]
set_load -pin_load 0.0334 [get_ports {done_out}]
set_load -pin_load 0.0334 [get_ports {out4}]
set_load -pin_load 0.0334 [get_ports {out5}]
set_load -pin_load 0.0334 [get_ports {out6}]
set_load -pin_load 0.0334 [get_ports {out7}]
set_load -pin_load 0.0334 [get_ports {out8}]
set_load -pin_load 0.0334 [get_ports {rx_out}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk_in}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {opcode_in0}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {opcode_in1}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {opcode_in2}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {opcode_in3}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst_in}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {start_in}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {tx_in}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
