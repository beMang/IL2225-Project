set_clock_latency -source -early -min -rise  -333.05 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -min -fall  -323.481 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -min -rise  -333.05 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -min -fall  -323.481 [get_ports {clk}] -clock clk 
