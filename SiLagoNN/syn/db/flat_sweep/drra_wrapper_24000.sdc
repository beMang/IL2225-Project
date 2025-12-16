create_clock -name "clk" -period 24000 -waveform {0 12000} [get_ports clk]

set_clock_uncertainty 240 [get_clock clk]

set_false_path -from [get_port rst_n]
