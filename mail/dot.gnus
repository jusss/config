;(setq gnus-select-method
;     '(nnimap "my mail"
;	       (nnimap-address "jusss.org")
;	       (nnimap-server-port 993)
;	       (nnimap-stream ssl)))
					;
; receive mail with offlineimap and store on ~/Maildir but still send mail with gnus, not other tool like msmtp
(setq gnus-select-method
      '(nnmaildir "jusss" (directory "~/Maildir")))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("jusss.org" 587 nil nil))
      smtpmail-auth-credentials '(("jusss.org" 587
				   "l" nil))
      smtpmail-default-smtp-server "jusss.org"
      smtpmail-smtp-server "jusss.org"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq-default
user-mail-address "l@jusss.org"
mm-text-html-renderer 'gnus-w3m
gnus-group-line-format "%M%S%5y/%R:%B%(%g%)\n"
gnus-summary-line-format "%U%R%z %(%&user-date; %-15,15f %B%s%)\n"
gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date)
gnus-summary-sort-functions '(gnus-summary-sort-by-most-recent-date)
gnus-sum-thread-tree-false-root ""
gnus-sum-thread-tree-indent " "
gnus-sum-thread-tree-leaf-with-other "├► "
gnus-sum-thread-tree-root ""
gnus-sum-thread-tree-single-leaf "╰► "
gnus-sum-thread-tree-vertical "│")

(setq gnus-parameters
  '((".*"
     (gcc-self . "Sent"))))

(setq message-default-mail-headers
      "Cc: jusss_@groups.163.com\nBcc: ifvwm1@gmail.com\n")

;postponed message is put in the following draft file
(setq message-auto-save-directory "~/Mail/drafts")

(setq gnus-gcc-mark-as-read t)

;(setq gnus-agent t)                                 ;开启agent 
;(setq read-mail-command 'gnus)                      ;使用gnus阅读邮件
;(setq mail-user-agent 'gnus-user-agent)             ;使用gnus发送邮件
(setq gnus-inhibit-startup-message t)               ;关闭启动时的画面
(setq gnus-novice-user nil)                         ;关闭新手设置, 不进行确认
(setq gnus-expert-user t)                           ;不询问用户
(setq gnus-show-threads t)                          ;显示邮件线索
(setq gnus-interactive-exit t)                      ;退出时进行交互式询问
(setq gnus-use-dribble-file t)                      ;创建恢复文件
(setq gnus-always-read-dribble-file t)              ;读取恢复文件
(setq gnus-asynchronous t)                          ;异步操作
(setq gnus-summary-display-while-building 50)  ;在生成summary时,每50封显示一下
(setq mm-inline-large-images t)                       ;显示内置图片
(add-to-list 'mm-attachment-override-types "image/*") ;附件显示图片

; this is configure for gnus-autocheck.el
;(load "~/lab/gnus-autocheck.el")
;(setq gnus-autocheck-interval (* 60 2))
;(setq gnus-autocheck-active-days '("Mon" "Tue" "Wed" "Thu" " Fri" "Sat" "Sun"))
;gnus-notify.el gnus-notify+.el doesn't work on emacs 24.4

;put cursor on the group like INBOX Sent in *Group* ,and then hit 'S l' you can get the level of current group and change it
;the default level of new group like INBOX, it's 3, and if the level is higher, and it's get less info when sync

;checking mail every 2 minutes
(defun my-check-mail ()
  "Fetch new mails only."
  ;special group level is 1, only check level 1, I just set INBOX group is level 1
  (gnus-group-get-new-news 2))
(add-hook 'gnus-startup-hook
	  '(lambda ()
	     ;check it every 2 mins
	     (gnus-demon-add-handler 'my-check-mail 3 nil)))

; only update level 3
;(setq gnus-activate-level 3) 

;another version is the next section
;this does a call to gnus-group-get-new-news You can have Gnus check for new mail every 5 minutes, the another version see above
;if only it's only this line without the next 8 lines config, it will auto check new mail and show it in *Group*, but don't show it on modeline
;but if it's with the next 8 lines config, and it will show nothing in *Group* buffer and show it on modeline for a while and show in *Group* don't show modeline
;(gnus-demon-add-handler 'gnus-demon-scan-news 5 t)

; when there's new mail , put an icon on modeline, new mail store on this location through offlineimap download
(setq display-time-mail-directory "~/Maildir/INBOX/new")
; if it's without the next section, and there a text 'Mail' on the modeline when there's new mail
(setq display-time-string-forms
      '((if display-time-day-and-date
           (format "%s %s %s" dayname monthname day) "")
        (format "%s:%s"
                24-hours minutes)
        (if mail (progn (start-process-shell-command "mail-sound" nil "mplayer -noconsolecontrols -really-quiet ~/sounds/mesg.wav 2>/dev/null") (propertize " " 'display display-time-mail-icon)))))
(display-time)

; don't ask me 'how many articles you want' again!
(setq gnus-large-newsgroup 'nil)
