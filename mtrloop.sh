#!/usr/bin/env bash 

# AUTHOR        : 
# CONTACT       : 
# OBJECTIVE     : 
# VERSION       : v0.1 20240922 Julio C. Pereira    Start         
#

#############################################
#pid
p_pid=$$

#############################################
# variables

# --example--
# v_customer="google_dns"
# v_target=8.8.8.8
# v_interval=0.3
# v_packets=10

# --manual definitions--
v_customer="google_dns"
v_target=8.8.8.8
v_interval=0.2
v_packets=100

#############################################
# -- definition --
v_tdy=""

#############################################
# -- auto definition --
v_dir="${v_customer}_pid${p_pid}"

#############################################
# --create--
mkdir -p $v_dir

#############################################
# functions

f_today() {
    v_today=$(date +%Y%m%d)
    echo "$v_today"
} 

f_clock() {
    v_clock=$(date +%H%M%S)
    echo "$v_clock"
}

f_date_clock() {
    v_dclock=$(date +%Y%m%d_%H%M%S)
    echo "$v_dclock"
}

f_mtr_run() {
    v_today=$(f_today)
    v_end=$(f_clock)
    mtr -t -o "LSD NBAW" -n -c $v_packets -i $v_interval $v_target -C > $v_dir/${v_today}_${v_customer}_${v_start}_${v_end}.log
}

#############################################
# run

while true; do 

    v_today=$(f_today)
    v_tdy=$(f_today)
    while [ "$v_today" == "$v_tdy" ]; do
        v_start=$(f_clock)
        f_mtr_run
        v_tdy=$(f_today)
        sleep 5
    done

done



