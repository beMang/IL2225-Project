# How to task 5 and task 6

**Always** In a terminal in ```/SiLagoNN/exe/```. To get the GUI, remove the ```-file``` arg and use ```source``` as the first command. 

## Create partitions

Will call ```read_design.tcl```, ```floorplan.tcl```, ```powerplan.tcl``` and ```partition.tcl```.

```bash
innovus -stylus -file ../phy/scr/create_partitions.tcl
```

## Place and Route Silago partitions

Execute and wait for the 6 processes to be finished.

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

