if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name LIBSET_BC\
   -timing\
    [list ${::IMEX::libVar}/mmmc/GF22FDX_SC8T_104CPP_BASE_CSC28L_FFG_0P72V_0P00V_0P00V_0P00V_M40C_ccs.lib.gz]
create_library_set -name LIBSET_WC\
   -timing\
    [list ${::IMEX::libVar}/mmmc/GF22FDX_SC8T_104CPP_BASE_CSC28L_SSG_0P72V_0P00V_0P00V_0P00V_125C_ccs.lib.gz]
create_library_set -name LIBSET_TC\
   -timing\
    [list ${::IMEX::libVar}/mmmc/GF22FDX_SC8T_104CPP_BASE_CSC28L_TT_0P80V_0P00V_0P00V_0P00V_25C_ccs.lib.gz]
create_timing_condition -name cond_typ\
   -library_sets [list LIBSET_TC]\
   -opcond TT_0P80V_0P00V_0P00V_0P00V_25C\
   -opcond_library GF22FDX_SC8T_104CPP_BASE_CSC28L_TT_0P80V_0P00V_0P00V_0P00V_25C
create_timing_condition -name cond_worst\
   -library_sets [list LIBSET_WC]\
   -opcond SSG_0P72V_0P00V_0P00V_0P00V_125C\
   -opcond_library GF22FDX_SC8T_104CPP_BASE_CSC28L_SSG_0P72V_0P00V_0P00V_0P00V_125C
create_timing_condition -name cond_best\
   -library_sets [list LIBSET_BC]\
   -opcond FFG_0P72V_0P00V_0P00V_0P00V_M40C\
   -opcond_library GF22FDX_SC8T_104CPP_BASE_CSC28L_FFG_0P72V_0P00V_0P00V_0P00V_M40C
create_rc_corner -name rc_typ\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -qrc_tech ${::IMEX::libVar}/mmmc/rc_typ/qrcTechFile
create_rc_corner -name rc_best\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -qrc_tech ${::IMEX::libVar}/mmmc/rc_best/qrcTechFile
create_rc_corner -name rc_worst\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -qrc_tech ${::IMEX::libVar}/mmmc/rc_worst/qrcTechFile
create_delay_corner -name WC_dc\
   -timing_condition {cond_worst}\
   -rc_corner rc_worst
create_delay_corner -name TC_dc\
   -timing_condition {cond_typ}\
   -rc_corner rc_typ
create_delay_corner -name BC_dc\
   -timing_condition {cond_best}\
   -rc_corner rc_best
create_constraint_mode -name functional\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/functional/functional.sdc]
create_analysis_view -name AVF_RCTYP -constraint_mode functional -delay_corner TC_dc -latency_file ${::IMEX::dataVar}/mmmc/views/AVF_RCTYP/latency.sdc
create_analysis_view -name AVF_RCBEST -constraint_mode functional -delay_corner BC_dc -latency_file ${::IMEX::dataVar}/mmmc/views/AVF_RCBEST/latency.sdc
create_analysis_view -name AVF_RCWORST -constraint_mode functional -delay_corner WC_dc -latency_file ${::IMEX::dataVar}/mmmc/views/AVF_RCWORST/latency.sdc
set_analysis_view -setup [list AVF_RCWORST] -hold [list AVF_RCBEST AVF_RCTYP]
