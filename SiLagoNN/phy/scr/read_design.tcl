source ../phy/scr/global_variables.tcl
source ${SCR_DIR}/design_variables.tcl

set_db init_power_nets {VDD}
set_db init_ground_nets {VSS}

read_mmmc ${MMMC_FILE}

read_physical -lef ${LEF_FILE}

read_netlist ${NETLIST_FILE}

init_design
