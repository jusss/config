#startdde
xhost +local: &
#pgrep wpa_supplicant || ~/network/wifi.sh &
#key bindings don't work, blame on setxkbmap or xcape? try .Xmodmap first
#setxkbmap -layout us -option ctrl:nocaps
#xcape
fcitx -rd&
#ibus-daemon -rdx&
#xss-lock -- xlock -timeout 1800 &
#disable xcompmgr, it will be more smooth, but conky will not be background transparent
#xcompmgr &
### blank the scren after a half hour
xset dpms 1800 1800 1800
xset s 1800
export GDK_BACKEND=x11
xinput set-prop 'Elan Touchpad' "libinput Natural Scrolling Enabled" 1

# notify daemon
/usr/lib/xfce4/notifyd/xfce4-notifyd &

[[ -f ~/.xmodmaprc ]] && xmodmap ~/.xmodmaprc #I dont know why this wont work
xmodmap ~/dot.Xmodmap& 
exec fvwm
#exec xmonad
#exec gnome-session
#exec startdde
#exec startxfce4
#
#after Xorg, 
#1. xmodmap ~/.Xmodmap
#2. neton
#3. conky
#4. stunnel stunnel.conf
#5. cd kcptun; ./kcpclient.sh; ./ssh.sh
