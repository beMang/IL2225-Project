set LOGID @\[IL2225-Project\]


puts "$LOGID TASK2 - FLAT LOGIC SYNTHESIS"


#Directory variables
set REPORT_DIR ../syn/rpt; # report directory for synthesis reports
set OUT_DIR    ../syn/db;  # output directory for netlist, sdf, sdc
set SOURCE_DIR ../rtl; 	   # source directory with the rtl
set SYN_DIR    ../syn; 	   # synthesis directory


puts {Pass | Period (ps) | Half-Period (ps) | Clock Uncertainty (ps) | Frequency (MHz)}
puts {1    | 30000       | 15000            | 300                    | 33.333         }
puts {2    | 28000       | 14000            | 280                    | 35.714         }
puts {3    | 26000       | 13000            | 260                    | 38.462         }
puts {4    | 24000       | 12000            | 240                    | 41.667         }
puts {5    | 22000       | 11000            | 220                    | 45.455         }
puts {6    | 20000       | 10000            | 200                    | 50.000         }
puts {7    | 18000       | 9000             | 180                    | 55.556         }
puts {8    | 16000       | 8000             | 160                    | 62.500         }
puts {9    | 15000       | 7500             | 150.0                  | 66.667         }
puts {10   | 14000       | 7000             | 140.0                  | 71.429         }
puts {11   | 13000       | 6500             | 130.0                  | 76.923         }
puts {12   | 12000       | 6000             | 120.0                  | 83.333         }
puts {13   | 11000       | 5500             | 110.0                  | 90.909         }
puts {14   | 10000       | 5000             | 100.0                  | 100.000        }
puts {15   | 9000        | 4500             | 90.0                   | 111.111        }
puts {16   | 8000        | 4000             | 80.0                   | 125.000        }
puts {17   | 6000        | 3000             | 60.0                   | 166.667        }
puts {18   | 4000        | 2000             | 40.0                   | 250.000        }
puts {19   | 3000        | 1500             | 30.0                   | 333.333        }
puts {20   | 2000        | 1000             | 20.0                   | 500.000        }


# set ConL [list 30000 28000 26000 24000 22000 20000 18000 16000 15000 14000 13000 12000 11000 10000 9000 8000 6000 4000 3000 2000]
set ConL [list 28000 24000 20000 16000 12000 8000 4000]
set ConLL [llength $ConL]
set i 1

foreach con  $ConL {
	set TIME_start [clock clicks -milliseconds]
	puts "$LOGID Constraint $i/$ConLL : clk_period $con \[ps\]"	

	source ../syn/scr/dc_flat_CON.tcl

	set TIME_taken [expr [expr [clock clicks -milliseconds] - $TIME_start]/60000]
	puts "$LOGID Constraint $i/$ConLL : Time taken $TIME_taken \[min\]"
	incr i
}