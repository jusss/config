fcitx &
### give access of connecting X to local program, and should use env DISPLAY=:0.0 command
xhost +local: &
### window manager must be the last program to run, and no &
exec fvwm2
