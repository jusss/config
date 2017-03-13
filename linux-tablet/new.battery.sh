#!/bin/bash
#modprobe i2c-dev
#modprobe test_power

# run this script in a screen

#search AXP288 chip on /dev/i2c-dev?
#for i in `seq 1 12`;
#do
#     RET=$(i2cget -f -y $i 0x34 0|cut -d 'x' -f1)
#     if [ $RET -eq 0 ]; then 
#     echo /dev/i2c-dev$i
#     I2C_DEV=$i
#     break	 
#     else I2C_DEV=-1;   
#fi
#done

#if [ $I2C_DEV -eq -1 ]; then
#echo "No AXP288 PMIC on i2c Bus"
#exit 113
#fi
# use above sections get i2c_dev is 12 so 
I2C_DEV=12

# force ADC enable for battery voltage and current
#i2cset -y -f $I2C_DEV 0x34 0x82 0xC3


while true
do
	CAPACITY=$((-128+16#$(i2cget -f -y $I2C_DEV 0x34 0xB9|cut -d 'x' -f 2)))
	if [ -z $CAPACITY ]; then
		echo "Could not read battery level; let's be more careful right now"
	else
	    echo "Battery level: $CAPACITY%"
	    #echo $CAPACITY%>/sys/module/test_power/parameters/battery_capacity
	    if [ $CAPACITY -le 10 ]; then
		exec /home/john/notifier.py "low battery" "power $CAPACITY%" &
	    fi
	    if [ $CAPACITY -ge 95 ]; then
		exec /home/john/notifier.py "battery" "power $CAPACITY%" &
	    fi
	fi
	sleep 300

done
