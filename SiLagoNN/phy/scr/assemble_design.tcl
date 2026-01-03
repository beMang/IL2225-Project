source ../phy/scr/global_variables.tcl
source ${SCR_DIR}/design_variables.tcl


read_db ${PART_DIR}/${TOP_NAME}.enc.dat/pnr


foreach module $master_partition_module_list {
    assemble_design -block_dir ${PART_DIR}/${module}.enc.dat/pnr \
                    -encounter_format
}


# Report
report_power      > ${RPT_DIR}/${TOP_NAME}_power.txt
report_constraint > ${RPT_DIR}/${TOP_NAME}_constraint.sdc
report_area       > ${RPT_DIR}/${TOP_NAME}_area.txt 
report_timing     > ${RPT_DIR}/${TOP_NAME}_timing.txt

# Export Netlist
write_db      ${OUTPUT_DIR}/${TOP_NAME}.dat
write_netlist ${OUTPUT_DIR}/${TOP_NAME}.v
