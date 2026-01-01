source ../phy/scr/global_variables.tcl
source ../phy/scr/design_variables.tcl

read_db .

place_design
ccopt_design
route_design

write_db ./pnr/

write_ilm

