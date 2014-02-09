#!/bin/bash
while [ 1 ]
do
	fetchmail|grep reading&&mplayer /home/jusss/uhem.wav -loop 5
	sleep 30m
done
