xrandr --output eDP1 --rotate right
fcitx &

### give access of connecting X to local program, and should use env DISPLAY=:0.0 command
### xhost +local: &

#setxkbmap -option ctrl:swapcaps
setxkbmap -layout us -option ctrl:nocaps

### xcape -e 'Control_L=Escape;Meta_L=Tab'
### because fvwm2 only use C-Tab to switch window, so don't change Tab to Meta_L in  xmodmap, and don't change Tab on xcape
### xcape -e 'Control_L=Escape'
xcape

### window manager must be the last program to run, and no &
exec fvwm2
