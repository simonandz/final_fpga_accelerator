set ::_synlig_defines [list]
verilog_defines -DPDK_sky130A
lappend ::_synlig_defines +define+PDK_sky130A
verilog_defines "-DSCL_sky130_fd_sc_hd\""
lappend ::_synlig_defines "+define+SCL_sky130_fd_sc_hd\""
verilog_defines -D__openlane__
lappend ::_synlig_defines +define+__openlane__
verilog_defines -D__pnr__
lappend ::_synlig_defines +define+__pnr__
verilog_defines -DUSE_POWER_PINS
lappend ::_synlig_defines +define+USE_POWER_PINS
read_verilog -sv -lib /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-07-44/tmp/be3c65c66a2d4dd3a7ffdfcf20c54e38.bb.v
set ::env(SYNTH_LIBS) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-07-44/tmp/960b988c4b58468bb4f75096d1556dac.lib
