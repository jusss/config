#!/bin/bash
while [ 1 ]
do
	fetchmail |grep -q  reading &&echo 'you have new mail in /var/mail/jusss' &&mplayer /home/jusss/uhem.wav -loop 3 >/dev/null 2>&1
	sleep 10m
done
