#!/bin/bash
pacman -Syu
chmod u+s /usr/bin/wpa_supplicant
chmod u+s /usr/bin/ip
chmod u+s /usr/bin/vboxreload
chmod u+s /usr/bin/systemctl
cat /usr/share/fcitx/addon/fcitx-clipboard.conf |sed 's/Enabled=True/Enabled=False/' > /usr/share/fcitx/addon/fcitx-clipboard.conf


