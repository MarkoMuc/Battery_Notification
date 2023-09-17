# Battery Notification

A simple Linux script for notifying the user when the battery charge reaches 25% while unplugged and 75% while plugged in. It also logs the time of the notification. It is to be used with a time-based job scheduler (eg. as a cron job).

## **Important**

A file (eg. config.sh) should be made to declare 2 variables :

- BATTERY_NOTIF_OFF - to turn off the notifications and logging
- LOGS_LOCATION - location for the log file

This file's full path should replace #LONG PATH TO THE FILE

```source #LONG PATH TO THE FILE```

## Future Changes

- [ ] Snooze notifications for X seconds 
- [ ] Add quite option that only logs
- [ ] Clean Up Code 
- [ ] ***FIN*** 
