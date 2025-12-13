puts "$LOGID Remove all Design"
remove_design -all


puts "$LOGID Setup Standard Cell Libraries"
source $SYN_DIR/synopsys_dc.setup


set TOP_NAME drra_wrapper


puts "$LOGID Load Design"
set hierarchy_files [split [read [open ${SOURCE_DIR}/${TOP_NAME}_hierarchy.txt r]] "\n"]
foreach filename [lrange ${hierarchy_files} 0 end-1] {
	puts "$LOGID $filename"
	analyze -format VHDL -lib WORK "${SOURCE_DIR}/${filename}"
}


puts "$LOGID Elaborate and Link"
elaborate $TOP_NAME
link


puts "$LOGID Constraints"
set con_clk $con
set con_half_clk [expr $con_clk/2]
set con_clk_unc [expr $con_clk/100]

create_clock -name "clk" -period ${con_clk} -waveform "0 ${con_half_clk}" [get_ports clk]
set_clock_uncertainty ${con_clk_unc} [get_clock clk]
set_false_path -from [get_port rst_n]


puts "$LOGID Compile Design"
compile -map_effort medium


puts "$LOGID Report"
#report_constraints 	> ${REPORT_DIR}/${TOP_NAME}_constratints_${con}.sdc
#report_area 		> ${REPORT_DIR}/${TOP_NAME}_area_${con}.txt
#report_cell 		> ${REPORT_DIR}/${TOP_NAME}_cells_${con}.txt
#report_timing 		> ${REPORT_DIR}/${TOP_NAME}_timing_${con}.txt
#report_power 		> ${REPORT_DIR}/${TOP_NAME}_power_${con}.txt

puts "$LOGID Export netlist"
write -hierarchy -format ddc     -output ${OUT_DIR}/${TOP_NAME}_${con}.ddc
write -hierarchy -format verilog -output ${OUT_DIR}/${TOP_NAME}_${con}.v

