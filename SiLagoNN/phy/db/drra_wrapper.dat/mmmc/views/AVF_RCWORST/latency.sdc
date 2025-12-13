set_clock_latency -source -early -max -rise  -490.032 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -481.881 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -490.032 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -481.881 [get_ports {clk}] -clock clk 
