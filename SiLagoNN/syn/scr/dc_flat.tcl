################################################################################
# Flat logic synthesis script
################################################################################
#
# This script is meant to be executed with the following directory structure
#
# project_top_folder
# |
# |- phy: physical synthesis material (scripts, pins, etc)
# |
# |- rtl: contains rtl code for the design, it should also contain a
# |       hierarchy.txt file with the all the files that compose the design
# |
# |- syn: logic synthesis material (this script, SDC constraints, etc)
#   |
#   |- db: store output data like mapped designs or physical files like GDSII
# |
# |- tb: testbenches for the rtl code & simulation stuff.
# |
# |- exe: the directory where it should be executed. This keeps all the temp files
#         created by DC in that directory
#
#
# The standard way of executing the script is from project_top_folder/exe
# with the following command
#
# $ dc_shell -f ../syn/scr/dc_flat.tcl
################################################################################

#Remove all Design
remove_design -all

#Directory variables
set REPORT_DIR ../syn/rpt; 			# report directory for synthesis reports on timing and area
set OUT_DIR    ../syn/db; 			# output directory for output files: netlist, sdf sdc.
set SOURCE_DIR ../rtl; 				# source directory with the rtl 
set SYN_DIR    ../syn; 				# synthesis directory

source ${SYN_DIR}/synopsys_dc.setup

set TOP_NAME drra_wrapper

# Read files
set hierarchy_files [split [read [open ${SOURCE_DIR}/${TOP_NAME}_hierarchy.txt r]] "\n"]
foreach filename [lrange ${hierarchy_files} 0 end-1] {
	puts "${filename}"
	analyze -format VHDL -lib WORK "${SOURCE_DIR}/${filename}"
}

elaborate ${TOP_NAME}
link

source ${SYN_DIR}/constraints.sdc;

compile -map_effort medium

report_constraints 	> ${REPORT_DIR}/${TOP_NAME}_constratints.sdc
report_area 		> ${REPORT_DIR}/${TOP_NAME}_area.txt
report_cell 		> ${REPORT_DIR}/${TOP_NAME}_cells.txt
report_timing 		> ${REPORT_DIR}/${TOP_NAME}_timing.txt
report_power 		> ${REPORT_DIR}/${TOP_NAME}_power.txt

# Export netlist
write -hierarchy -format ddc -output ${OUT_DIR}/${TOP_NAME}.ddc
write -hierarchy -format verilog -output ${OUT_DIR}/${TOP_NAME}.v