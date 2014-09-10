echo 0 > /sys/class/rtc/rtc0/wakealarm
echo `date '+%s' -d '+ 2 minutes'` > /sys/class/rtc/rtc0/wakealarm
