################################################################################
# Design Compiler bottom-up logic synthesis script
################################################################################
#
# This script is meant to be executed with the following directory structure
#
# project_top_folder
# |
# |- db: store output data like mapped designs or physical files like GDSII
# |
# |- phy: physical synthesis material (scripts, pins, etc)
# |
# |- rtl: contains rtl code for the design, it should also contain a
# |       hierarchy.txt file with the all the files that compose the design
# |
# |- syn: logic synthesis material (this script, SDC constraints, etc)
# |
# |- sim: simulation stuff like waveforms, reports, coverage etc.
# |
# |- tb: testbenches for the rtl code
# |
# |- exe: the directory where it should be executed. This keeps all the temp files
#         created by DC in that directory
#
#
# The standard way of executing the is from the project_top_folder
# with the following command
#
# $ dc_shell -f ../syn/scr/dc_bottomup.tcl
################################################################################


#Directory variables
set REPORT_DIR ../syn/rpt; 			# report directory for synthesis reports on timing and area
set OUT_DIR ../db; 				# output directory for output files: netlist, sdf sdc.
set SOURCE_DIR ../rtl; 				# source directory with the rtl 
set SYN_DIR ../syn; 				# synthesis directory

remove_design -all

# load synopsys config
source ${SYN_DIR}/synopsys_dc.setup

set TOP_NAME drra_wrapper;

proc precompile {name n} {
	global SOURCE_DIR SYN_DIR OUT_DIR
	set prev_n [expr {$n - 1}]
	analyze -format vhdl -lib WORK "${SOURCE_DIR}/mtrf/${name}.vhd"
    elaborate ${name}
    current_design ${name}
    link
    uniquify
    source ${SYN_DIR}/constraints.sdc
    if  {$n > 1} {
        source ${OUT_DIR}/${name}_${prev_n}.wscr
    }
}

#EXECUTE N PASSES. DECIDE ON A REASONABLE N.
proc nth_pass {n} {
	global SOURCE_DIR SYN_DIR OUT_DIR TOP_NAME
	puts "${n} pass"
    #Hint: Write constraints for some reasonably big modules. E.g: divider_pipe and silego. (divider_pipe ??)
    #Hint: Compile only the unique tiles
	
	#Compile MTRF_cell
    precompile MTRF_cell $n
    compile
	
	#Compile Silego
	precompile silego $n
	dont_touch MTRF_cell true
	compile
	
	#Compile Silago top block
	set silago_tiles {
		"Silago_top_left_corner"
		"Silago_top"
		"Silago_top_right_corner"
		"Silago_bot_left_corner"
		"Silago_bot"
		"Silago_bot_right_corner"
	}

	foreach tile $silago_tiles {
		precompile $tile $n
		dont_touch MTRF_cell true
		dont_touch silego true
		compile
	}

    #compile drra_wrapper toplevel
    analyze -format vhdl -lib WORK "${SOURCE_DIR}/mtrf/${TOP_NAME}.vhd"
    elaborate $TOP_NAME
    current_design $TOP_NAME
    link
    uniquify
    source ${SYN_DIR}/constraints.sdc
    
    #get new names from uniqify for dont_touch
    set silago_top_instances [get_cells -hierarchical Silago_top* -quiet]
	set silago_bot_instances [get_cells -hierarchical Silago_bot* -quiet]
	set sub_tiles [list MTRF_cell silego]
	
	set silago_instances [concat $silago_top_instances $silago_bot_instances]
	set all_instances [concat $sub_tiles $silago_instances]
	
	# Mark them as dont_touch
	foreach cell $all_instances {
		dont_touch $cell true
	}
	
    compile

    #check if the constraints are met
    report_constraint
    report_area
    report_power
    report_timing
    report_constraint
    
    #Characterize blocks
    foreach inst $silago_instances {
		characterize -constraint $inst #some instance are not valid (WHY ?)
	}
    
    #save scripts for next pass
    set unique_designs [list MTRF_cell silego]
	set unique_designs [concat $unique_designs $silago_tiles]
	foreach design $unique_designs {
		current_design $design #top and bot cells are not found
		write_script > ${OUT_DIR}/${design}_${n}.wscr
	}
}

# Read files from hierarchy_files
set hierarchy_files [split [read [open ${SOURCE_DIR}/silego_hierarchy.txt r]] "\n"]
foreach filename [lrange ${hierarchy_files} 0 end-1] {
	puts "${filename}"
	analyze -format vhdl -lib WORK "${SOURCE_DIR}/${filename}"
}

set N_pass 2
for {set pass 1} {$pass <= $N_pass} {incr pass} {
    nth_pass $pass
}

current_design $TOP_NAME
report_area > ${REPORT_DIR}/area.txt
report_power > ${REPORT_DIR}/power.txt
report_timing > ${REPORT_DIR}/timing.txt
write_file -format verilog -hier -output ${OUT_DIR}/${TOP_NAME}.v

