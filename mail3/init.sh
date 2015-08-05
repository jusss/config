#!/bin/bash

# this file can be a startup script to call other script, like low-battery-warning.sh mail-notify.sh, run this file and make them running


~/lab/xcape.sh &
~/lab/network.sh &
~/lab/mail-notify.py
