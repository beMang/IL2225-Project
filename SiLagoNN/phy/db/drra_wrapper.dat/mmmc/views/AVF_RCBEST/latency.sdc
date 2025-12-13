set_clock_latency -source -early -min -rise  -356.587 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -min -fall  -342.191 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -min -rise  -356.587 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -min -fall  -342.191 [get_ports {clk}] -clock clk 
