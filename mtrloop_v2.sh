#!/usr/bin/env bash 

# AUTHOR        : Julio C. Pereira
# CONTACT       : github.com/julliopereira
# OBJECTIVE     : test with mtr without interruption 
# VERSION       : v0.1 20240922 Julio C. Pereira    Start         
#                 v1.0 20240922 Julio C. Pereira    Date and time added in front of mtr report

#############################################
#pid
p_pid=$$  # Stores the current process ID in the variable p_pid

#############################################
# variables

# --manual definitions--
v_customer="japan.jp"  # Defines the customer as "google_dns"
v_target=japan.jp # Sets the target (IP address) to 8.8.8.8
v_interval=0.25  # Defines the interval between packets as 0.2 seconds
v_packets=100  # Defines the number of packets as ...

#############################################
# -- definition --
v_tdy=""  # Initializes the variable v_tdy as empty

#############################################
# -- auto definition --
v_dir="${v_customer}_pid${p_pid}"  # Defines the directory as <customer>_pid<process>

#############################################
# --create--
mkdir -p $v_dir  # Creates the directory if it does not already exist

#############################################
# functions

f_today() {
    v_today=$(date +%Y%m%d)  # Captures the current date in the format YYYYMMDD
    echo "$v_today"  # Returns the current date
} 

f_clock() {
    v_clock=$(date +%H%M%S)  # Captures the current time in the format HHMMSS
    echo "$v_clock"  # Returns the current time
}

f_date_clock() {
    v_dclock=$(date +%Y%m%d_%H%M%S)  # Captures the current date and time in the format YYYYMMDD_HHMMSS
    echo "$v_dclock"  # Returns the date and time in the above format
}

f_date_clock_two() {
    v_dclock=$(date +%Y%m%d_%H:%M:%S)  # Captures the current date and time in the format YYYYMMDD_HHMMSS
    echo "$v_dclock"  # Returns the date and time in the above format
}

f_mtr_run() {
    v_today=$(f_today)  # Gets the current date
    # Executes the mtr (My Traceroute) command with options and saves the log to a file
    v_now=$(f_date_clock_two)
    mtr -t -o "LSD NBAW" -n -c $v_packets -i $v_interval $v_target -r >> $v_dir/${v_today}_${v_customer}_${v_start}.log
    sed -i "s/^/$v_now\t/g" $v_dir/${v_today}_${v_customer}_${v_start}.log
}

#############################################
# run

while true; do  # Infinite loop for continuous execution

    v_today=$(f_today)  # Gets today's date
    v_tdy=$(f_today)  # Initializes v_tdy with the current date
    while [ "$v_today" == "$v_tdy" ]; do  # While the current date is still today
        v_start=$(f_clock)  # Gets the start time
        f_mtr_run  # Executes the f_mtr_run function to run mtr and save the log
        v_tdy=$(f_today)  # Updates v_tdy with the current date
        sleep 5  # Waits for 5 seconds before continuing
    done

    # If mtrloop.sh not running then stop
    if ! ps -p $p_pid > /dev/null; then
        break
    fi    

done  # End of the loop
