#!/bin/bash

# This is used as cronjob or any other time-based job scheduler, exits with 1 if not in range otherwise 0
# Checks if battery is <=25% and discharging or >=75% and charging, if true sends a notfication
# It also logs the time of the notification in format : dd/mm/yy 24h time - value - state

source #LONG PATH TO THE FILE

parse=$(upower -i $BATTERY_PATH)

# Parse the information received from upower
val=$(echo "$parse" | grep "percentage" | grep -o "[0-9]*")
state=$(echo "$parse" | grep "state" | grep -o "discharging")
capacity=$(echo "$parse" | grep "capacity" | grep -o "[0-9]*\.[0-9]*")

if [ "${BATTERY_NOTIF_OFF,,}" == "true" ]; then
    exit 0
elif { [ $val -le 25 ] && [ "$state" == "discharging" ]; } || { [ $val -ge 75 ] && [ "$state" == "" ]; }; then
    if [ "${BATTERY_QUIET,,}" == "false" ]; then
        notif_message="Plug-In charger, Battery $val%"

        if [ $val -ge 75 ]; then
            notif_message="Un-Plug charger, Battery $val%"
        fi
        
        notify-send -u normal -t 45000 -a "Battery" "$notif_message"
    fi

    if [ $val -eq 25 ] || [ $val -eq 75 ]; then
        
        if [ $val -eq 75 ]; then
            state="charging"
        fi

        if [ ! -e "$BATTERY_LOGS_LOCATION/battery_notif.log" ]; then
            echo "$(date +"%m/%d/%Y - %T") - $val% - $state - $capacity%" >> $BATTERY_LOGS_LOCATION/battery_notif.log
            exit 0
        fi

        lastlog=$(cat $BATTERY_LOGS_LOCATION/battery_notif.log | tail -n 1);
        datelog=$(echo "$lastlog" |cut -d "-" -f 1) 
        datelog=$(date -d "$datelog" +%s)
        timelog=$(echo "$lastlog" | cut -d "-" -f 2)
        timelog=$(date -d $timelog +%s)
        
        if [ "$datelog" -lt "$(date -d "$(date +"%m/%d/%Y")" +%s)" ] || [ "$(($(date +%s) - timelog))" -gt 300 ]; then 
            echo "$(date +"%m/%d/%Y - %T") - $val% - $state - $capacity%" >> $BATTERY_LOGS_LOCATION/battery_notif.log
        fi
    fi
    
    exit 0
fi

exit 1

