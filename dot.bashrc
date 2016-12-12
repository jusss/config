#vim character override issue, caught by default ~/.bashrc, delete it and touch new ~/.bashrc will be fine
# alias ec='emacsclient -t'
alias ec='emacs -nw'
alias halt='halt -p'
# alias scp='scp -P 0 -i ~/.ssh/id_rsa'
# alias ssh='ssh -p 0 x@x.org'
alias poweroff='systemctl poweroff'
alias standby='sleep 1&&xset dpms force standby'
alias cr='chromium &exit'
alias ls='ls -t --color'
alias virtualbox='virtualbox &exit'
alias firefox='firefox &exit'
alias cp='cp -i'
alias mv='mv -i'
alias suspend='echo mem|sudo tee /sys/power/state'
alias hibernate='echo disk|sudo tee /sys/power/state'
# systemctl hibernate and suspend will cause power loss

