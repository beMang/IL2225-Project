create_clock -name "clk" -period 60000 -waveform {0 10} [get_ports clk]
set_clock_uncertainty 300 [get_clock clk]
set_false_path -from [get_port rst_n]
