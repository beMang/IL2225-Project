set margin 20
set width  165
set height 200

create_floorplan -site SC8T_104CPP_CMOS22FDX -core_size [expr {8*$width}] [expr {2*$height}] $margin $margin $margin $margin -no_snap_to_grid

for {set i 0} {$i < 8} {incr i} {
#Top row
    set x1 [expr {double($margin + $width * $i)}]
    set y1 [expr {double($margin + $height    )}]
    set x2 [expr {double($x1 + $width )}]
    set y2 [expr {double($y1 + $height)}]

    set cell [lindex ${all_partition_hinst_list} $i ]
    create_boundary_constraint -type fence -hinst $cell -rects [list [list $x1 $y1 $x2 $y2]]
#Bottom row
    set y1 [expr {double($margin)}]
    set y2 [expr {double($y1 + $height)}]

    set j [expr {$i + 8}]
    set cell [lindex ${all_partition_hinst_list} $j ]
    create_boundary_constraint -type fence -hinst $cell -rects [list [list $x1 $y1 $x2 $y2]]
}

update_floorplan_obj -obj Silago_top_inst_3_0 -rects {514.937 219.684 679.881 420.004}
update_floorplan_obj -obj Silago_bot_inst_3_1 -rects {514.933 20.0 679.877 219.68}
update_floorplan_obj -obj Silago_top_inst_4_0 -rects {679.879 219.675 844.823 419.995}
update_floorplan_obj -obj Silago_bot_inst_4_1 -rects {679.88 20.009 844.824 219.689}
update_floorplan_obj -obj Silago_top_inst_5_0 -rects {844.819 219.652 1009.763 419.972}
update_floorplan_obj -obj Silago_bot_inst_5_1 -rects {844.833 20.0 1009.777 219.68}
update_floorplan_obj -obj Silago_top_inst_6_0 -rects {1009.763 219.68 1174.707 420.0}
update_floorplan_obj -obj Silago_bot_inst_6_1 -rects {1009.759 19.969 1174.703 219.649}
update_floorplan_obj -obj Silago_top_r_corner_inst_7_0 -rects {1174.711 219.68 1339.655 420.0}
update_floorplan_obj -obj Silago_bot_r_corner_inst_7_1 -rects {1174.696 20.019 1339.64 219.699}
