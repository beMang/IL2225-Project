# margin around core
set margin 40
# spacing between Silago instances for routing to pins
set spacing 40
# Silago block size
set width  200
set height 200

create_floorplan -site SC8T_104CPP_CMOS22FDX -core_size [expr {9*$spacing + 8*$width}] [expr {3*$spacing + 2*$height}] $margin $margin $margin $margin -no_snap_to_grid

for {set i 0} {$i < 8} {incr i} {
#Top row
    set x1 [expr {double($margin + ($spacing * ($i+1)) + ($width * $i))}]
    set y1 [expr {double($margin + ($spacing *  2   ) +  $height     )}]
    set x2 [expr {double($x1 + $width )}]
    set y2 [expr {double($y1 + $height)}]

    set cell [lindex ${all_partition_hinst_list} $i ]
    create_boundary_constraint -type fence -hinst $cell -rects [list [list $x1 $y1 $x2 $y2]]
#Bottom row
    set y1 [expr {double($margin + $spacing)}]
    set y2 [expr {double($y1 + $height)}]

    set j [expr {$i + 8}]
    set cell [lindex ${all_partition_hinst_list} $j ]
    create_boundary_constraint -type fence -hinst $cell -rects [list [list $x1 $y1 $x2 $y2]]
}
