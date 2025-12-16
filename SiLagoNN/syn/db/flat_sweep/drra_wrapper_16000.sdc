create_clock -name "clk" -period 16000 -waveform {0 8000} [get_ports clk]

set_clock_uncertainty 160 [get_clock clk]

set_false_path -from [get_port rst_n]
