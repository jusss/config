#!/bin/bash
killall wpa_supplicant > /dev/null 2>&1
sleep 1
# wpa_supplicant -iwlp3s0 -c ~/networks/home -Dwext -d >> ~/lab/log 2>&1 &
wpa_supplicant -iwlp3s0 -c ~/networks/home -Dwext > /dev/null 2>&1 &
sleep 2
# ip address, subnet mask, broadcast address, device interface
ip addr add 192.168.2.254/24 broadcast 192.168.2.255 dev wlp3s0
# route address
ip route add default via 192.168.2.1
# for dnsmasq
#echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
systemctl stop dnsmasq
sudo python /home/jusss/lab/part-ii-dns-relay.py


