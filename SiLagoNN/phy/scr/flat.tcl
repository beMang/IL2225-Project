set LOGID @\[IL2225-Project\]

puts "$LOGID TASK4 - FLAT PHYSICAL DESIGN"


set TIME_start [clock clicks -milliseconds]


# Read design
source ../phy/scr/read_design.tcl

# Floorplanning
source ../phy/scr/floorplan.tcl

# Power Planning
source ../phy/scr/powerplan.tcl

# Placement
place_design
assign_io_pins

# Clock Tree Routing
ccopt_design

# Route Design
route_design

# Report
report_power      > ${RPT_DIR}/${TOP_NAME}_power.txt
report_constraint > ${RPT_DIR}/${TOP_NAME}_constraint.sdc
report_area       > ${RPT_DIR}/${TOP_NAME}_area.txt 
report_timing     > ${RPT_DIR}/${TOP_NAME}_timing.txt

# Export Netlist
write_db ../phy/db/drra_wrapper.dat
write_netlist ../phy/db/drra_wrapper.v


set TIME_taken [expr [expr [clock clicks -milliseconds] - $TIME_start]/60000]
puts "$LOGID : Time taken $TIME_taken \[min\]"
