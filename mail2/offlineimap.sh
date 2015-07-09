#!/bin/bash

sleep 5

while true;do
    {
	# pidof can recognize the difference between offlineimap.sh and offlineimap, pgrep doesn't
	PID=$(pidof -x offlineimap)
	if [ -n "$PID" ]; then
	    kill -9 $PID
	else
	    offlineimap >> ~/lab/log 2>&1 &
	fi
	sleep 5m
    }
done

	    
