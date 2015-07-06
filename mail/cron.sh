#!/bin/bash

# this file can be a startup script to call other script, like low-battery-warning.sh mail-notify.sh, run this file and make them running

while true;do
{
    offlineimap >> /home/jusss/cron.log &
    sleep 5m
}
done

	    
