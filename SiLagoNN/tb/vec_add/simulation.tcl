#	From /SiLagoNN/tb/vec_add run: 
#	vsim -do simulation.tcl

vlib work
vlib dware

set TOP_NAME silagonn
set RUN_TIME "1000ns"
  
set SOURCE_DIR "../../rtl"
set TB_DIR "."

set dware_hierarchy_files [split [read [open ${SOURCE_DIR}/dware_hierarchy.txt r]] "\n"]
set hierarchy_files [split [read [open ${SOURCE_DIR}/${TOP_NAME}_hierarchy.txt r]] "\n"]

#	Compile
foreach filename [lrange ${dware_hierarchy_files} 0 end-1] {
	vcom -2008 -work dware ${SOURCE_DIR}/${filename}
}

foreach filename [lrange ${hierarchy_files} 0 end-1] {
	vcom -2008 -work work ${SOURCE_DIR}/${filename}
}

vcom -2008 -work work ${TB_DIR}/const_package.vhd
vcom -2008 -work work ${TB_DIR}/testbench.vhd

#	Run sim
vsim -voptargs=+acc work.testbench
do wave.do

run ${RUN_TIME}
