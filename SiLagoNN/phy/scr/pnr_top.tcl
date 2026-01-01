source ../phy/scr/global_variables.tcl
source ../phy/scr/design_variables.tcl

cd ../phy/db/part
read_db ${TOP_NAME}

foreach module $master_partition_module_list {
	read_ilm -cell $module -dir ${module}/ilm
}
flatten_ilm

place_design
ccopt_design
route_design -placement_check

write_db ${TOP_NAME}/pnr/

