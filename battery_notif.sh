#!/bin/bash

# This is used as cronjob or any other time-based job scheduler, exits with 1 if not in range otherwise 0
# Checks if battery is <=25% and discharging or >=75% and charging, if true sends a notfication
# It also logs the time of the notification in format : dd/mm/yy 24h time - value - state


source #LONG PATH TO THE FILE

val=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "percentage" | grep -o "[0-9]*")
state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "state" | grep -o "discharging")

if [ "$BATTERY_NOTIF_OFF" == "1" ]; then
    #notify-send -u normal -t 45000 "Battery" "Off"
    exit 0
elif [ $val -le 25 ] && [ "$state" == "discharging" ]; then
    notify-send -u normal -t 45000 "Battery" "Plug-In charger, Battery $val%"
    if [ $val -eq 25 ] ; then echo "$(date +"%d/%m/%Y %T") - $val% - $state" >> $LOGS_LOCATION/battery_notif.log; fi
    exit 0
elif [ $val -ge 75 ] && [ "$state" == "" ]; then
    notify-send -u normal -t 45000 -a Battery "Un-Plug charger, Battery $val%"
    if [ $val -eq 75 ] ; then echo "$(date +"%d/%m/%Y %T") - $val% - charging" >> $LOGS_LOCATION/battery_notif.log; fi
    exit 0
fi

exit 1
