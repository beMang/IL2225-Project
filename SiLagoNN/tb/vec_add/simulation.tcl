#===================================
#to execute in SiLagoNN/exe/ folder. -> do ../tb/vec_add/simulation.tcl
# + testbench.vdh has been modified such that *instruction.bin* is read from the correct folder.
#===================================
vlib work
vlib dware

set SOURCE_DIR ../rtl;
set TB_DIR     ../tb/vec_add;  

#1. Compile dware libraries into "dware" and the design into "work"

# dware :
set hierarchy_files_dware [split [read [open ${SOURCE_DIR}/dware_hierarchy.txt r]] "\n"]

foreach filename [lrange ${hierarchy_files_dware} 0 end-1] {
    if {[string equal [file extension $filename] ".vhd"]} {
        vcom -2008  -work dware ${SOURCE_DIR}/${filename}
    } else {
        vlog -v2001 -work dware ${SOURCE_DIR}/${filename}
    }
}

# work :
set hierarchy_files [split [read [open ${SOURCE_DIR}/silagonn_hierarchy.txt r]] "\n"]

foreach filename [lrange ${hierarchy_files} 0 end-1] {
    if {[string equal [file extension $filename] ".vhd"]} {
        vcom -2008  -work work ${SOURCE_DIR}/${filename}
    } else {
        vlog -v2001 -work work ${SOURCE_DIR}/${filename}
    }
}

#2. Compile testbench.
vcom -2008 -work work ${TB_DIR}/const_package.vhd
vcom -2008 -work work ${TB_DIR}/testbench.vhd

#3. Run simulation.
vsim -voptargs=+acc work.testbench
do wave.do
run 1000ns;
