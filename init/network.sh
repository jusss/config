#!/bin/bash
killall wpa_supplicant > /dev/null 2>&1
sleep 2
wpa_supplicant -iwlp3s0 -c ~/networks/home -Dwext -d >> ~/lab/log 2>&1 &
sleep 2
# ip address, subnet mask, broadcast address, device interface
sudo ip addr add 192.168.1.254/24 broadcast 192.168.1.255 dev wlp3s0
# route address
sudo ip route add default via 192.168.1.1
# for dnsmasq
#echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf


