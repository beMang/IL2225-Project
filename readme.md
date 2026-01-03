# How to task 5 and task 6

<<<<<<< HEAD
**Always** In a terminal in `/SiLagoNN/exe/`. To get the GUI, remove the `-file` arg and use `source` as the first command. 
=======
**Always** in a terminal in ```/SiLagoNN/exe/```. To get the GUI, remove the ```-file``` arg and use ```source``` as the first command. 
>>>>>>> fe41b0988a2a8c3f94cd4241c939cc02a8e6b567

## Create partitions

Will call `read_design.tcl`, `floorplan.tcl`, `powerplan.tcl` and `partition.tcl`.

```bash
innovus -stylus -file ../phy/scr/create_partitions.tcl
```

## Place and Route Silago partitions

Execute and wait for the 6 processes to be finished. Use the *System Monitor* or the `.logv` files to asses end of process.

```bash
../phy/scr/pnr_partitions.sh
```

## Place and Route drra_wrapper

```bash
innovus -stylus -file ../phy/scr/pnr_top.tcl
```

## Assemble the design

```bash
innovus -stylus -file ../phy/scr/assemble_design.tcl
```

