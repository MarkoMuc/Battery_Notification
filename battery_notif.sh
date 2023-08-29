#!/bin/bash

# This is used as cronjob or any other time-based job scheduler, exits with 1 if not in range otherwise 0
# Checks if battery is <=25% and discharging or >=75% and charging, if true sends a notfication
# It also logs the time of the notification in format : dd/mm/yy 24h time - value - state


source #LONG PATH TO THE FILE

parse=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1)

# Parse the information received form upower
val=$(echo "$parse" | grep "percentage" | grep -o "[0-9]*")
state=$(echo "$parse" | grep "state" | grep -o "discharging")
capacity=$(echo "$parse" | grep "capacity" | grep -o "[0-9]*\.[0-9]*")

if [ "${BATTERY_NOTIF_OFF,,}" == "true" ]; then
    #notify-send -u normal -t 45000 "Battery" "Off"
    exit 0
elif [ $val -le 25 ] && [ "$state" == "discharging" ]; then
    notify-send -u normal -t 45000 "Battery" "Plug-In charger, Battery $val%"
    if [ $val -eq 25 ] ; then
        lastlog=$(cat $LOGS_LOCATION/battery_notif.log | tail -n 1);
        
        datelog=$(echo "$lastlog" |cut -d "-" -f 1) 
        datelog=$(date -d "$datelog" +%s)
        timelog=$(echo "$lastlog" | cut -d "-" -f 2)
        timelog=$(date -d $timelog +%s)
        
        if [ "$datelog" -lt "$(date -d "$(date +"%m/%d/%Y")" +%s)" ] || [ "$(($(date +%s) - timelog))" -gt 300 ]; then 
            echo "$(date +"%m/%d/%Y - %T") - $val% - $state - $capacity%" >> $LOGS_LOCATION/battery_notif.log
        fi
    fi
    
    exit 0
elif [ $val -gt 75 ] && [ "$state" == "" ]; then
    notify-send -u normal -t 45000 -a Battery "Un-Plug charger, Battery $val%"
    if [ $val -eq 75 ] ; then 
        lastlog=$(cat $LOGS_LOCATION/battery_notif.log | tail -n 1);
        
        datelog=$(echo "$lastlog" |cut -d "-" -f 1) 
        datelog=$(date -d "$datelog" +%s)
        timelog=$(echo "$lastlog" | cut -d "-" -f 2)
        timelog=$(date -d $timelog +%s)
        
        if [ "$datelog" -lt "$(date -d "$(date +"%m/%d/%Y")" +%s)" ] || [ "$(($(date +%s) - timelog))" -gt 300 ]; then
            echo "$(date +"%m/%d/%Y - %T") - $val% - charging - $capacity%" >> $LOGS_LOCATION/battery_notif.log
        fi
    fi
    exit 0
fi

exit 1

