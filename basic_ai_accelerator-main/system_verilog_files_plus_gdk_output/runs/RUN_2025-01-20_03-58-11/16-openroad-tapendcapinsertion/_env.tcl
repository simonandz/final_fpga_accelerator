set ::env(STEP_ID) OpenROAD.TapEndcapInsertion
set ::env(TECH_LEF) /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
set ::env(MACRO_LEFS) ""
set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hd
set ::env(VDD_PIN) VPWR
set ::env(VDD_PIN_VOLTAGE) 1.80
set ::env(GND_PIN) VGND
set ::env(TECH_LEFS) "\"nom_*\" /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef \"min_*\" /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__min.tlef \"max_*\" /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__max.tlef"
set ::env(GPIO_PADS_LEF) "/foss/pdks/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io.lef /foss/pdks/sky130A/libs.ref/sky130_fd_io/lef/sky130_ef_io.lef"
set ::env(GPIO_PADS_LEF_CORE_SIDE) "/foss/pdks/sky130A/libs.tech/openlane/custom_cells/lef/sky130_fd_io_core.lef /foss/pdks/sky130A/libs.tech/openlane/custom_cells/lef/sky130_ef_io_core.lef"
set ::env(GPIO_PADS_VERILOG) /foss/pdks/sky130A/libs.ref/sky130_fd_io/verilog/sky130_ef_io.v
set ::env(GPIO_PAD_CELLS) "\"sky130_fd_io*\" \"sky130_ef_io*\""
set ::env(PRIMARY_GDSII_STREAMOUT_TOOL) magic
set ::env(DATA_WIRE_RC_LAYER) met2
set ::env(CLOCK_WIRE_RC_LAYER) met5
set ::env(DEFAULT_CORNER) nom_tt_025C_1v80
set ::env(STA_CORNERS) "nom_tt_025C_1v80 nom_ss_100C_1v60 nom_ff_n40C_1v95 min_tt_025C_1v80 min_ss_100C_1v60 min_ff_n40C_1v95 max_tt_025C_1v80 max_ss_100C_1v60 max_ff_n40C_1v95"
set ::env(FP_TRACKS_INFO) /foss/pdks/sky130A/libs.tech/openlane/sky130_fd_sc_hd/tracks.info
set ::env(FP_TAPCELL_DIST) 13
set ::env(FP_IO_HLAYER) met3
set ::env(FP_IO_VLAYER) met2
set ::env(RT_MIN_LAYER) met1
set ::env(RT_MAX_LAYER) met5
set ::env(SCL_GROUND_PINS) "VGND VNB"
set ::env(SCL_POWER_PINS) "VPWR VPB"
set ::env(TRISTATE_CELLS) "\"sky130_fd_sc_hd__ebuf*\""
set ::env(FILL_CELL) "\"sky130_fd_sc_hd__fill*\""
set ::env(DECAP_CELL) "sky130_fd_sc_hd__decap_3 sky130_fd_sc_hd__decap_4 sky130_fd_sc_hd__decap_6 sky130_fd_sc_hd__decap_8 sky130_ef_sc_hd__decap_12"
set ::env(LIB) "\"*_tt_025C_1v80\" /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib \"*_ss_100C_1v60\" /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v60.lib \"*_ff_n40C_1v95\" /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ff_n40C_1v95.lib"
set ::env(CELL_LEFS) "/foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd.lef /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef"
set ::env(CELL_GDS) /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd.gds
set ::env(CELL_VERILOG_MODELS) "/foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
set ::env(CELL_BB_VERILOG_MODELS) "/foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd__blackbox.v /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd__blackbox_pp.v"
set ::env(CELL_SPICE_MODELS) "/foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__decap_12.spice /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_12.spice /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_4.spice /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_ef_sc_hd__fill_8.spice /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice"
set ::env(SYNTH_EXCLUDED_CELL_FILE) /foss/pdks/sky130A/libs.tech/openlane/sky130_fd_sc_hd/no_synth.cells
set ::env(PNR_EXCLUDED_CELL_FILE) /foss/pdks/sky130A/libs.tech/openlane/sky130_fd_sc_hd/drc_exclude.cells
set ::env(OUTPUT_CAP_LOAD) 33.442
set ::env(MAX_FANOUT_CONSTRAINT) 10
set ::env(MAX_TRANSITION_CONSTRAINT) 0.75
set ::env(MAX_CAPACITANCE_CONSTRAINT) 0.2
set ::env(CLOCK_UNCERTAINTY_CONSTRAINT) 0.25
set ::env(CLOCK_TRANSITION_CONSTRAINT) 0.1499999999999999944488848768742172978818416595458984375
set ::env(TIME_DERATING_CONSTRAINT) 5
set ::env(IO_DELAY_CONSTRAINT) 20
set ::env(SYNTH_DRIVING_CELL) sky130_fd_sc_hd__inv_2/Y
set ::env(SYNTH_TIEHI_CELL) sky130_fd_sc_hd__conb_1/HI
set ::env(SYNTH_TIELO_CELL) sky130_fd_sc_hd__conb_1/LO
set ::env(SYNTH_BUFFER_CELL) sky130_fd_sc_hd__buf_2/A/X
set ::env(WELLTAP_CELL) sky130_fd_sc_hd__tapvpwrvgnd_1
set ::env(ENDCAP_CELL) sky130_fd_sc_hd__decap_3
set ::env(PLACE_SITE) unithd
set ::env(CELL_PAD_EXCLUDE) "\"sky130_fd_sc_hd__tap*\" \"sky130_fd_sc_hd__decap*\" \"sky130_ef_sc_hd__decap*\" \"sky130_fd_sc_hd__fill*\""
set ::env(DIODE_CELL) sky130_fd_sc_hd__diode_2/DIODE
set ::env(DESIGN_NAME) systolic_top_uart_4parallel_q8_24
set ::env(CLOCK_PERIOD) 20
set ::env(CLOCK_PORT) clk
set ::env(FALLBACK_SDC_FILE) /usr/local/lib/python3.10/dist-packages/openlane/scripts/base.sdc
set ::env(PDN_CONNECT_MACROS_TO_GRID) 1
set ::env(PDN_ENABLE_GLOBAL_CONNECTIONS) 1
set ::env(FP_MACRO_HORIZONTAL_HALO) 10
set ::env(FP_MACRO_VERTICAL_HALO) 10
set ::env(CURRENT_ODB) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-58-11/15-openroad-cutrows/systolic_top_uart_4parallel_q8_24.odb
set ::env(SAVE_ODB) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-58-11/16-openroad-tapendcapinsertion/systolic_top_uart_4parallel_q8_24.odb
set ::env(SAVE_DEF) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-58-11/16-openroad-tapendcapinsertion/systolic_top_uart_4parallel_q8_24.def
set ::env(SAVE_SDC) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-58-11/16-openroad-tapendcapinsertion/systolic_top_uart_4parallel_q8_24.sdc
set ::env(SAVE_NETLIST) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-58-11/16-openroad-tapendcapinsertion/systolic_top_uart_4parallel_q8_24.nl.v
set ::env(SAVE_POWERED_NETLIST) /foss/designs/system_verilog_converted_files/runs/RUN_2025-01-20_03-58-11/16-openroad-tapendcapinsertion/systolic_top_uart_4parallel_q8_24.pnl.v
set ::env(_SDC_IN) /usr/local/lib/python3.10/dist-packages/openlane/scripts/base.sdc
set ::env(_PNR_LIBS) /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
set ::env(_MACRO_LIBS) ""
set ::env(_PNR_EXCLUDED_CELLS) "sky130_fd_sc_hd__lpflow_clkbufkapwr_1 sky130_fd_sc_hd__a2111oi_0 sky130_fd_sc_hd__lpflow_bleeder_1 sky130_fd_sc_hd__xnor3_1 sky130_fd_sc_hd__a21boi_0 sky130_fd_sc_hd__lpflow_decapkapwr_4 sky130_fd_sc_hd__lpflow_clkbufkapwr_8 sky130_fd_sc_hd__xnor3_2 sky130_fd_sc_hd__lpflow_isobufsrckapwr_16 sky130_fd_sc_hd__buf_16 sky130_fd_sc_hd__mux4_4 sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1 sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2 sky130_fd_sc_hd__lpflow_inputisolatch_1 sky130_fd_sc_hd__xor3_1 sky130_fd_sc_hd__fa_4 sky130_fd_sc_hd__lpflow_inputiso1p_1 sky130_fd_sc_hd__lpflow_clkbufkapwr_16 sky130_fd_sc_hd__lpflow_decapkapwr_3 sky130_fd_sc_hd__lpflow_clkbufkapwr_4 sky130_fd_sc_hd__probe_p_8 sky130_fd_sc_hd__clkdlybuf4s18_1 sky130_fd_sc_hd__xor3_2 sky130_fd_sc_hd__xor3_4 sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4 sky130_fd_sc_hd__lpflow_isobufsrc_2 sky130_fd_sc_hd__lpflow_isobufsrc_4 sky130_fd_sc_hd__lpflow_inputiso0p_1 sky130_fd_sc_hd__lpflow_isobufsrc_16 sky130_fd_sc_hd__o311ai_0 sky130_fd_sc_hd__xnor3_4 sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4 sky130_fd_sc_hd__lpflow_decapkapwr_6 sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1 sky130_fd_sc_hd__lpflow_clkinvkapwr_16 sky130_fd_sc_hd__lpflow_clkinvkapwr_1 sky130_fd_sc_hd__lpflow_inputiso1n_1 sky130_fd_sc_hd__lpflow_clkinvkapwr_4 sky130_fd_sc_hd__lpflow_inputiso0n_1 sky130_fd_sc_hd__lpflow_clkinvkapwr_2 sky130_fd_sc_hd__lpflow_clkinvkapwr_8 sky130_fd_sc_hd__and2_0 sky130_fd_sc_hd__lpflow_isobufsrc_8 sky130_fd_sc_hd__or2_0 sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2 sky130_fd_sc_hd__lpflow_decapkapwr_8 sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4 sky130_fd_sc_hd__o21ai_0 sky130_fd_sc_hd__lpflow_clkbufkapwr_2 sky130_fd_sc_hd__lpflow_decapkapwr_12 sky130_fd_sc_hd__lpflow_isobufsrc_1 sky130_fd_sc_hd__probec_p_8 sky130_fd_sc_hd__clkdlybuf4s15_1"
