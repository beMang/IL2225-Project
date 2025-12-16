create_clock -name "clk" -period 8000 -waveform {0 4000} [get_ports clk]

set_clock_uncertainty 80 [get_clock clk]

set_false_path -from [get_port rst_n]
