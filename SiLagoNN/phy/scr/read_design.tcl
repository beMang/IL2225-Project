#1. source global variables
source ../phy/scr/global_variables.tcl

#2. source design variables
source ../phy/scr/design_variables.tcl

#3. set vdd net
set_db init_power_nets {VDD}

#4. set vss net
set_db init_ground_nets {VSS}

#5. read mmmc file
read_mmmc ${MMMC_FILE}

#6. read lef 
read_physical -lef ${LEF_FILE}

#7. read logic synthesis netlist
read_netlist ${NETLIST_FILE}

init_design

