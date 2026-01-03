# How to task 1, 2 and 4

> Task 5 and 6 are located in the `hierarchy` branch and task 3 in `adrien`'s branch.

**Always** in a terminal in `/SiLagoNN/exe/`.

## Task 1 - Simulation of RTL design

```bash
vsim -do sim.tcl
```

`sim.tcl`

```tcl
vsim -voptargs=+acc work.testbench
do ../tb/vec_add/wave.do
run 1000ns;
```

## Task 2 - Flat logic synthesis

```bash
dc_shell -f ../syn/scr/dc_flat.tcl
```

To run the sweep over clk periods.

```bash
dc_shell -f ../syn/scr/dc_flat_sweep.tcl
```

## Task 4 - Flat Physical synthesis

```bash
innovus -stylus -file flat.tcl
```

To run the sweep over clk periods.

```bash
../phy/scr/flat_sweep.sh
```
