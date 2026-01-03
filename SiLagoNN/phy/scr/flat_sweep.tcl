set LOGID @\[IL2225-Project\]


puts "$LOGID TASK4 - FLAT PHYSICAL DESIGN"
puts {Pass | Period (ps) | Half-Period (ps) | Clock Uncertainty (ps) | Frequency (MHz)}
puts {1    | 28000       | 14000            | 280                    | 35.714         }
puts {2    | 24000       | 12000            | 240                    | 41.667         }
puts {3    | 20000       | 10000            | 200                    | 50.000         }
puts {4    | 16000       | 8000             | 160                    | 62.500         }
puts {5    | 12000       | 6000             | 120                    | 83.333         }
puts {6    | 8000        | 4000             | 80                     | 125.000        }
puts {7    | 4000        | 2000             | 40                     | 250.000        }


set ConL [list 28000 24000 20000 16000 12000 8000 4000]
set ConLL [llength $ConL]
set i 1

foreach con  $ConL {
    set TIME_start [clock clicks -milliseconds]
    puts "$LOGID Constraint $i/$ConLL : clk_period $con \[ps\]"	

    source ../phy/scr/flat_CON.tcl

    set TIME_taken [expr [expr [clock clicks -milliseconds] - $TIME_start]/60000]
    puts "$LOGID Constraint $i/$ConLL : Time taken $TIME_taken \[min\]"
    incr i
}