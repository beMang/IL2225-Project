create_clock -name "clk" -period 12000 -waveform {0 6000} [get_ports clk]

set_clock_uncertainty 120 [get_clock clk]

set_false_path -from [get_port rst_n]
