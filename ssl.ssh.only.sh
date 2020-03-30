#!/bin/bash
systemctl start iptables
systemctl enable iptables
iptables -A INPUT -i lo -p tcp --dport 1990 -j ACCEPT
iptables -A INPUT -p tcp --dport 1990 -j DROP
iptables-save -f /etc/iptables/iptables.rules
