# Battery Notification

A simple Linux script for notifying the user when the battery charge reaches 25% while unplugged and 75% while plugged in. It also logs the time of the notification. It is to be used with a time-based job scheduler (eg. as a cron job).

## **Important**

A file (eg. config.sh) should be made to declare 4 variables :
| Variable    | Description    | Values    |
|---------------- | --------------- | --------------- |
| BATTERY_NOTIF_OFF | Turn off notifications *and* logging | true/false |
| BATTERY_QUIET | Turn off notifications | true/false |
| BATTERY_LOGS_LOCATION | Log file location | Path String |
| BATTERY_PATH | Battery path used in *upower* | Path String |


This file's full path should replace #LONG PATH TO THE FILE

```source #LONG PATH TO THE FILE```

## Future Changes

- [X] Add quite option that only logs
- [ ] Clean Up Code 
- [ ] ***FIN*** 
