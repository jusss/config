#!/bin/bash
pgrep wpa_supplicant || sudo wpa_supplicant -iwlp3s0 -c ~/network/3700v4.wpa &
sleep 1
pgrep dhcpcd || sudo dhcpcd -S ip_address=192.168.2.210/24 -S routers=192.168.2.1 -S domain_name_servers=127.0.0.1 wlp3s0 &
