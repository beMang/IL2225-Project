set LOGID @\[IL2225-Project\]

puts "$LOGID Read design data"
# Read design (modified from read_design.tcl)
##############################################################################
## 1. source global variables
source ../phy/scr/global_variables.tcl
### Update
### Directories
set OUTPUT_DIR "../phy/db/flat_sweep"
set RPT_DIR    "../phy/rpt/flat_sweep"
### we need a part directory where partitions are created
set PART_DIR   "../phy/db/part"
set SRC_DIR    "../syn/db/flat_sweep"

set MMMC_FILE          "${SCR_DIR}/mmmc.tcl"
set NETLIST_FILE       "${SRC_DIR}/${TOP_NAME}_${con}.v"
set SDC_FILES          "${SRC_DIR}/${TOP_NAME}_${con}.sdc"

## 2. source design variables
set_multi_cpu_usage -local_cpu ${NUM_CPUS} -cpu_per_remote_host 1 -remote_host 0 -keep_license true

set_distributed_hosts -local

## 3. set vdd net
set_db init_power_nets {VDD}

## 4. set vss net
set_db init_ground_nets {VSS}

## 5. read mmmc file
read_mmmc ${MMMC_FILE}

## 6. read lef 
read_physical -lef ${LEF_FILE}

## 7. read logic synthesis netlist
read_netlist ${NETLIST_FILE}

init_design
##############################################################################

puts "$LOGID Floorplanning"
source ../phy/scr/floorplan.tcl

puts "$LOGID Power Planning"
source ../phy/scr/powerplan.tcl

puts "$LOGID Placement"
place_design
assign_io_pins

puts "$LOGID Clock Tree Routing"
ccopt_design

puts "$LOGID Route Design"
route_design

puts "LOGID Report"
report_power      > ${RPT_DIR}/${TOP_NAME}_power_${con}.txt
report_constraint > ${RPT_DIR}/${TOP_NAME}_constraint_${con}.sdc
report_area       > ${RPT_DIR}/${TOP_NAME}_area_${con}.txt
report_timing     > ${RPT_DIR}/${TOP_NAME}_timing_${con}.txt

puts "LOGID Export Netlist"
write_db      ${OUTPUT_DIR}/drra_wrapper_${con}.dat
write_netlist ${OUTPUT_DIR}/drra_wrapper_${con}.v