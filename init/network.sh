#!/bin/bash
killall wpa_supplicant > /dev/null 2>&1
sudo killall dhcpcd > /dev/null 2>&1
wpa_supplicant -iwlp3s0 -c ~/networks/home -Dwext -d >> ~/lab/log 2>&1 &
sleep 2
# Don't set any default routes. then it's not necessary to change /etc/resolv.conf every time after you change it once
sudo dhcpcd -G -4 wlp3s0 >> ~/lab/log 2>&1 & 
# for dnsmasq
#sleep 10
#echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf >> ~/lab/log 2>&1 &


