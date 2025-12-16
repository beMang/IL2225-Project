create_clock -name "clk" -period 4000 -waveform {0 2000} [get_ports clk]

set_clock_uncertainty 40 [get_clock clk]

set_false_path -from [get_port rst_n]
