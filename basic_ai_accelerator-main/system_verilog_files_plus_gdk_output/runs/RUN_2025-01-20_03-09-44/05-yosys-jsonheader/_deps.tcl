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
read_verilog -sv -lib /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-09-44/tmp/48d6c55e406d464a89bff25d1cf0c788.bb.v
set ::env(SYNTH_LIBS) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-09-44/tmp/04c54b2088b44b9b999e4ee2a24b34a6.lib
