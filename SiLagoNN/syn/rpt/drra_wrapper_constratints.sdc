Information: Updating design information... (UID-85)
Warning: Design 'drra_wrapper' contains 6 high-fanout nets. A fanout number of 1000 will be used for delay calculations involving these nets. (TIM-134)
 
****************************************
Report : constraint
Design : drra_wrapper
Version: V-2023.12-SP4
Date   : Thu Nov 27 21:15:54 2025
****************************************


                                                   Weighted
    Group (max_delay/setup)      Cost     Weight     Cost
    -----------------------------------------------------
    clk                       3678.29      1.00   3678.29
    default                      0.00      1.00      0.00
    -----------------------------------------------------
    max_delay/setup                               3678.29

                              Total Neg  Critical
    Group (critical_range)      Slack    Endpoints   Cost
    -----------------------------------------------------
    clk                      76981600.00
                                              1   3678.29
    default                      0.00         0      0.00
    -----------------------------------------------------
    critical_range                                3678.29

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
    max_delay/setup                               3678.29 (VIOLATED)
    sequential_clock_pulse_width                 5728927.00
                                                          (VIOLATED)
    critical_range                                3678.29 (VIOLATED)


1
