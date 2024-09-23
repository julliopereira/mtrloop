#!/usr/bin/env bash 

# AUTHOR        : Julio C. Pereira
# CONTACT       : github.com/julliopereira
# OBJECTIVE     : 
# VERSION       : v0.1 20240922 Julio C. Pereira    Start         
#

#############################################
#pid
p_pid=$$  # Stores the current process ID in the variable p_pid

#############################################
# variables

# --manual definitions--
v_customer="google_dns"  # Defines the customer as "google_dns"
v_target=8.8.8.8  # Sets the target (IP address) to 8.8.8.8
v_interval=0.2  # Defines the interval between packets as 0.2 seconds
v_packets=3600  # Defines the number of packets as 100

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

f_mtr_run() {
    v_today=$(f_today)  # Gets the current date
    # Executes the mtr (My Traceroute) command with options and saves the log to a file
    mtr -t -o "LSD NBAW" -n -c $v_packets -i $v_interval $v_target -C > $v_dir/${v_today}_${v_customer}_${v_start}.log
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

done  # End of the loop