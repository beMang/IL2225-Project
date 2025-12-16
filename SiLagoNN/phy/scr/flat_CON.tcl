# Remove previous design data
puts "$LOGID Remove previous design data"
remove_design -all

# Read design
puts "$LOGID Read design data"

## 1. source global variables
source ../phy/scr/global_variables.tcl
### Update
### Directories
set OUTPUT_DIR "../phy/db/flat"
set RPT_DIR    "../phy/rpt/flat"
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
