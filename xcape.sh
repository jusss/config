#!/bin/bash
killall xcape > /dev/null 2>&1
# xcape -e 'Control_L=Escape;Meta_L=Tab'
# because fvwm2 only use C-Tab to switch window, so don't change Tab to Meta_L in  xmodmap, and don't change Tab on xcape
xcape -e 'Control_L=Escape'
