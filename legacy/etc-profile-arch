# /etc/profile

#Set our umask
umask 022

# Set our default path
PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"
export PATH

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Source global bash config
if test "$PS1" && test "$BASH" && test -r /etc/bash.bashrc; then
	. /etc/bash.bashrc
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH

export LANG=C
export LANGUAGE=C
export LC_CTYPE=zh_CN.UTF-8
export LC_NUMERIC=C
export LC_TIME=C
export LC_COLLATE=C
export LC_MONETARY=C
export LC_MESSAGES=C
export LC_PAPER=C
export LC_NAME=C
export LC_ADDRESS=C
export LC_TELEPHONE=C
export LC_MEASUREMENT=C
export LC_IDENTIFICATION=C
export LC_ALL=

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

alias ex='ex -c %p'
