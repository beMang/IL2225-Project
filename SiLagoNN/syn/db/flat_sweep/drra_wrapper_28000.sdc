create_clock -name "clk" -period 28000 -waveform {0 14000} [get_ports clk]

set_clock_uncertainty 280 [get_clock clk]

set_false_path -from [get_port rst_n]
