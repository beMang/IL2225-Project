Information: Updating design information... (UID-85)
Warning: Design 'drra_wrapper' contains 6 high-fanout nets. A fanout number of 1000 will be used for delay calculations involving these nets. (TIM-134)
 
****************************************
Report : constraint
Design : drra_wrapper
Version: V-2023.12-SP4
Date   : Mon Dec  1 23:20:58 2025
****************************************


                                                   Weighted
    Group (max_delay/setup)      Cost     Weight     Cost
    -----------------------------------------------------
    clk                       1170.42      1.00   1170.42
    default                      0.00      1.00      0.00
    -----------------------------------------------------
    max_delay/setup                               1170.42

                              Total Neg  Critical
    Group (critical_range)      Slack    Endpoints   Cost
    -----------------------------------------------------
    clk                      2545327.25
                                             11  12874.58
    default                      0.00         0      0.00
    -----------------------------------------------------
    critical_range                               12874.58

                                                   Weighted
    Group (min_delay/hold)       Cost     Weight     Cost
    -----------------------------------------------------
    clk (no fix_hold)            0.00      1.00      0.00
    default                      0.00      1.00      0.00
    -----------------------------------------------------
    min_delay/hold                                   0.00


    Constraint                                       Cost
    -----------------------------------------------------
    min_capacitance                                321.46 (VIOLATED)
    max_transition                                   0.00 (MET)
    max_capacitance                                  0.00 (MET)
    max_delay/setup                               1170.42 (VIOLATED)
    sequential_clock_pulse_width                     0.00 (MET)
    critical_range                               12874.58 (VIOLATED)


1
