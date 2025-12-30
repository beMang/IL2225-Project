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

proc compile_shared {design rtl_file} {
    puts "Compiling shared block: $design"

    analyze  -format vhdl -lib WORK $rtl_file
    elaborate $design
    current_design $design
    link

    compile

    # HARD FREEZE: no cloning, no restructuring
    set_ungroup $design false
    dont_touch $design

    # Save for reuse
    write -format ddc -hierarchy -output ${design}.ddc
}

proc read_hierarchy {} {
    global SOURCE_DIR
    set fh [open ${SOURCE_DIR}/silego_hierarchy.txt r]
    set files [split [read $fh] "\n"]
    close $fh

    foreach f [lrange $files 0 end-1] {
        analyze -format vhdl -lib WORK "${SOURCE_DIR}/$f"
    }
}

read_hierarchy

compile_shared MTRF_cell  ${SOURCE_DIR}/mtrf/MTRF_cell.vhd
compile_shared silego     ${SOURCE_DIR}/mtrf/silego.vhd
compile_shared Silago_top ${SOURCE_DIR}/mtrf/Silago_top.vhd
compile_shared Silago_bot ${SOURCE_DIR}/mtrf/Silago_bot.vhd

set UNIQUE_TILES {
    Silago_top_left_corner
    Silago_top
    Silago_top_right_corner
    Silago_bot_left_corner
    Silago_bot
    Silago_bot_right_corner
}

set N_pass 2

for {set pass 1} {$pass <= $N_pass} {incr pass} {
    puts "\n========== Pass number : $pass ==========\n"

    foreach tile $UNIQUE_TILES {
        puts "Compiling unique tile: $tile"
        analyze  -format vhdl -lib WORK "${SOURCE_DIR}/mtrf/${tile}.vhd"
        elaborate $tile
        current_design $tile
        link

        source ${SYN_DIR}/constraints.sdc

        # Shared designs are already frozen
        compile

        write_script > ${OUT_DIR}/${tile}_${pass}.wscr
    }
}

puts "\n========== TOP LEVEL ==========\n"

analyze  -format vhdl -lib WORK "${SOURCE_DIR}/mtrf/${TOP_NAME}.vhd"
elaborate $TOP_NAME
current_design $TOP_NAME
link
source ${SYN_DIR}/constraints.sdc

# Protect ALL shared instances
set shared_instances [get_cells -hierarchical *Silago*]
foreach inst $shared_instances {
    dont_touch $inst true
}

compile

#Verfication :
get_designs *Silego*
get_designs MTRF_cell
get_designs silego

#report :
report_constraint > ${REPORT_DIR}/constraints.txt
report_area       > ${REPORT_DIR}/area.txt
report_power      > ${REPORT_DIR}/power.txt
report_timing     > ${REPORT_DIR}/timing.txt

#output
write_file -format verilog -hierarchy -output ${OUT_DIR}/${TOP_NAME}.v
write_sdf -version 2.1 ${OUT_DIR}/${TOP_NAME}.sdf
write_sdc ${OUT_DIR}/${TOP_NAME}.sdc


