# Task 2: Flat synthesis for multiple clock periods
# Run in exe/task_2/ dc_shell:
# source ../../syn/scr/dc_flat.tcl

set SOURCE_DIR	"../../rtl"
set SYN_DIR	"../../syn"
set OUT_DIR	"../../syn/db/task_2"
set REPORT_DIR	"../../syn/rpt/task_2"
set TOP_NAME drra_wrapper

set periods {20000 15000 8000 4000 2000}
foreach T $periods {
	remove_design -all
	source ../../syn/synopsys_dc.setup

	set hierarchy_files [split [read [open ${SOURCE_DIR}/${TOP_NAME}_hierarchy.txt r]] "\n"]
	foreach filename [lrange ${hierarchy_files} 0 end-1] {
		analyze -format VHDL -lib WORK "${SOURCE_DIR}/${filename}"
	}
	elaborate ${TOP_NAME}
	link
	
	# 50% duty cycle with 1% jitter/skew excluding reset signal
	set half_T [expr $T / 2]
	set unc [expr $T / 100]
	create_clock -name "clk" -period ${T} -waveform "0 ${half_T}" [get_ports clk]
	set_clock_uncertainty ${unc} [get_clock clk]
	set_false_path -from [get_port rst_n]

	compile -map_effort medium

	report_area > ${REPORT_DIR}/${TOP_NAME}_area_${T}ps.txt
	report_cell > ${REPORT_DIR}/${TOP_NAME}_cells_${T}ps.txt
	report_timing > ${REPORT_DIR}/${TOP_NAME}_timing_${T}ps.txt
	report_power > ${REPORT_DIR}/${TOP_NAME}_power_${T}ps.txt
	report_constraints > ${REPORT_DIR}/${TOP_NAME}_con_${T}ps.txt

	# database and netlist for physical synthesis    
	write -hierarchy -format ddc -output ${OUT_DIR}/${TOP_NAME}_${T}ps.ddc
	write -hierarchy -format verilog -output ${OUT_DIR}/${TOP_NAME}_${T}ps.v
}
