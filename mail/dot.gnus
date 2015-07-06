;(setq gnus-select-method
;     '(nnimap "my mail"
;	       (nnimap-address "x.org")
;	       (nnimap-server-port 993)
;	       (nnimap-stream ssl)))
					;
; receive mail with offlineimap and store on ~/Maildir but still send mail with gnus, not other tool like msmtp
(setq gnus-select-method
      '(nnmaildir "jusss" (directory "~/Maildir")))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("x.org" 587 nil nil))
      smtpmail-auth-credentials '(("x.org" 587
				   "user-name" nil))
      smtpmail-default-smtp-server "x.org"
      smtpmail-smtp-server "x.org"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq-default
user-mail-address "x@x.org"
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
  "Cc: x@x.com\nBcc: x@gmail.com\n")

(setq gnus-gcc-mark-as-read t)

;(load "~/gnus-autocheck.el")
;(setq gnus-autocheck-interval (* 60 10))
;(setq gnus-autocheck-active-days '("Mon" "Tue" "Wed" "Thu" " Fri" "Sat" "Sun"))
