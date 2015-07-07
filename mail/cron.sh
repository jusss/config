#!/bin/bash

# this file can be a startup script to call other script, like low-battery-warning.sh mail-notify.sh, run this file and make them running

PID=$(pgrep offlineimap)

while true;do
    {
	if [ -n "$PID" ]; then
	    kill -9 $PID
	else
	    offlineimap >> /home/jusss/cron.log &
	fi
	sleep 5m
    }
done

	    
