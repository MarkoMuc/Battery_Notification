# Battery Notification

A simple Linux tool for notifying the user when the battery charge hits 25% while unplugged and 75% while plugged. It also logs the time of the notification. It is to be used with a time-based job scheduler (eg. as a cron job).

## **Important**

A file (eg. config.sh) should be made to hold the values for 2 variables :

- BATTERY_NOTIF_OFF - to turn off the notifications and logging
- LOGS_LOCATION - location for the log file

The file's long path should replace #LONG PATH TO THE FILE

```source #LONG PATH TO THE FILE```
