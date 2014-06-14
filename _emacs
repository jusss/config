(create-fontset-from-fontset-spec
"-outline-Consolas-normal-r-normal-normal-16-120-96-96-c-*-iso8859-1,
ascii:-outline-Consolas-normal-r-normal-normal-16-120-96-96-c-*-iso8859-1,
chinese-gbk:-outline-新宋体-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1
chinese-gb2312:-outline-新宋体-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1")

;set english font
(set-default-font "-outline-新宋体-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1")

;set startup window
(setq default-frame-alist
'( (top . 50) (left . 200)
(height . 35) (width . 100) (menu-bar-lines . 20) (tool-bar-lines . 0)))

;cancel startup msg 
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message "Administrator")

;set erc
(defun lirc ()
	(erc :server "irc.freenode.net" :port 6665 :nick "jusss"
    :password "h3lloworld")
	(setq erc-autojoin-channels-alist '(("freenode.net" "#scheme" "#lisp"
	"#ubuntu-cn"))))
(setq erc-autojoin-timing 'ident)
