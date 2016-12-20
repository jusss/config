;;; for reading, run `emacs -q -l reading.el` will read reading.el as startup file not ~/.emacs
;;; C-h a read-only RET get C-x C-q will change the current buffer to read-only mode, or you can change the file to read-only with chmod command
;;; emacs config for archlinux

;;; slime is for common lisp, geiser is for scheme, elpy is for python
;;;cider for clojure, eclim for java, inf-ruby for ruby
;;; scroll up/down for reading 
;;; (global-set-key (kbd "z") 'scroll-up-command)
;;; (global-set-key (kbd "a") 'scroll-down-command)

;;; (add-to-list 'load-path (expand-file-name "~/elisp"))

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;font can be set in .Xdefaults
;(set-face-attribute 'default nil
;		    :family "SimSun"
;		    :height 100)
(setq confirm-nonexistent-file-or-buffer nil)
(transient-mark-mode -1)
(ido-mode t)
(global-set-key (kbd "C-,") 'ido-switch-buffer)
(global-set-key (kbd "C-;") 'set-mark-command)
;;; emacs -nw in screen, C-; doesn't work, so set M-; as set-mark-command
;;;M-; runs the command comment-dwim, which is an interactive compiled
;;;Lisp function in `newcomment.el'.
(global-set-key (kbd "M-;") 'set-mark-command)
;;; C-u C-; jump to the previous mark position only in local buffer
;;; C-x C-; jump to the previous mark position in global buffer
(global-set-key (kbd "C-x C-;") 'pop-global-mark)

;os clipboard swap with kill-ring

;(setq interprogram-cut-fucntion 'x-select-text)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;(setq x-select-enable-clipboard t)
;(setq select-active-regions t)
;(setq yank-pop-change-selection t)
;(setq save_interprogram-paste_before-kill t)

(require `erc)
(require `tls)
(global-set-key (kbd "C-.")
		(lambda ()
		  "server ip can't be as variable's type"
		  (interactive)
		  (erc-ssl :server "irc.freenode.net" 
			   :port 7000 
			   :nick "x" 
			   :full-name "x" 
			   :password "x")
		  (setq erc-autojoin-channels-alist '(("freenode.net"
						       "#archlinux"
						       "#emacs")))))
;;;		  (setq erc-autojoin-timing 'ident)))
;;; waiting for identify, then join channel

(show-paren-mode t)
(setq completion-ignore-case t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gnutls-min-prime-bits 2048))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:foreground "orange red"))))
 '(erc-action-face ((t nil)))
 '(erc-button ((t nil)))
 '(erc-current-nick-face ((t (:foreground "red" :weight bold))))
 '(erc-input-face ((t (:foreground "#004e00"))))
 '(erc-my-nick-face ((t (:foreground "#ff5500" :weight bold))))
 '(erc-nick-default-face ((t nil)))
 '(erc-nick-msg-face ((t (:foreground "red"))))
 '(erc-notice-face ((t (:foreground "SlateBlue"))))
 '(erc-timestamp-face ((t (:foreground "green"))))
 '(gnus-button ((t nil)))
 '(gnus-emphasis-bold ((t nil)))
 '(ido-first-match ((t nil)))
 '(message-header-subject ((t (:foreground "navy blue"))))
 '(message-header-to ((t (:foreground "MidnightBlue"))))
 '(mode-line ((t (:background "snow" :foreground "forest green" :box (:line-width -1 :style released-button)))))
 '(mode-line-buffer-id ((t nil)))
 '(widget-button ((t nil))))
(set-background-color "#e7f4fe")
(set-foreground-color "#004e00")
(set-face-foreground 'fringe "#e7f4fe")
(set-face-background 'fringe "#e7f4fe")
;;; remove erc header-line
(setq erc-header-line-format nil)
(setq gnus-asynchronous t)
(setq gnus-use-cache t)
(global-set-key (kbd "C-'") 'gnus)

;;;(add-hook 'erc-text-matched-hook 'erc-sound-if-not-server)
;;;    (defun erc-sound-if-not-server (match-type nickuserhost msg)
;;;      (unless (string-match "Server:[0-9]+" nickuserhost)
;;;        (start-process-shell-command "ercsound" nil "mplayer -noconsolecontrols -really-quiet ~/sounds/Sirrah.ogg 2>/dev/null")))

;;; erc notifier
;;; http://emacser.com/erc.htm
;;;(add-hook 'erc-text-matched-hook 'john-erc-text-matched-hook)
;;;(defun john-erc-text-matched-hook (match-type nickuserhost message)
;;;  "Shows a notification, when user's nick was mentioned.
;;;     If the buffer is currently not visible, makes it sticky."
;;;  (when (and (erc-match-current-nick-p nickuserhost message)
;;;	     ;;; include these strings then no notification
;;;             (not (string-match (regexp-opt '("Users"
;;;                                              "User"
;;;                                              "topic set by"
;;;                                              "Welcome to "
;;;                                              "nickname"
;;;                                              "identified"
;;;                                              "invalid"
;;;                                              ))
;;;                                message)))
;;;    (let ((s (concat "ERC: " (buffer-name (current-buffer)))))
;;;      (case system-type
;;;        ((darwin)
;;;         (john-erc-notifier s message))))))
;;;
;;;(defun john-erc-notifier (title message)
;;;  (start-process-shell-command "erc-notifier" "erc-notify" "env DISPLAY=:0.0 ~/lab/notifier.py" title message))
;;;don't use (start-process-shell-command) because shell will resolve and execute 'message' from erc-text-matched-hook
(add-hook 'erc-text-matched-hook 'john-erc-notifier)
(defun john-erc-notifier (match-type nickuserhost message)
  ;;; if message contain these strings then no notification
  (unless (string-match (regexp-opt '("*** Users on #"
				      "has changed mode for "
				      "*** Welcome "
				      "*** Your new nickname is"
				      "topic set by"
				      "You are now identified for "
				      "is now your hidden host"
				      "unaffiliated/jusss"
				      ))
			message)
    (start-process "erc-notify"
		   "erc-notify"
		   "/usr/bin/env"
		   "DISPLAY=:0.0"
		   "/home/jusss/lab/erc-notifier.py"
		   "erc"
		   message)))
;;;if it run at Xorg :1, then change DISPLAY environment, or just comment env and DISPLAY lines

;; emacsclient x clipboard swap xsel
(setq x-select-enable-clipboard t)
(unless window-system
  (when (getenv "DISPLAY")
    (defun xsel-cut-function (text &optional push)
      (with-temp-buffer
	(insert text)
	(call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    (defun xsel-paste-function()
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
	(unless (string= (car kill-ring) xsel-output)
	  xsel-output)))
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)))

;; display time on mode bar
(display-time-mode 1)
(require 'w3m-load)

;;; disable auto fill mode, if it enable, input like 'a b RET c', it maybe change to 'a RET b c', special when you're composing mail in gnus
;;; use C-h m or M-x describe-mode to get the name of major mode in current buffer
;;; and add hook to disable auto-fill-mode
;;;(add-hook 'message-mode-hook 'turn-off-auto-fill)
;;;`C-q SPC' or `C-q LFD' (recall that a newline is really a linefeed).
;;;Also, `C-o' inserts a newline without line breaking.
;;;http://www.cs.cmu.edu/cgi-bin/info2www?(emacs)Auto%20Fill
(add-hook 'message-mode-hook 'turn-on-auto-fill)

;;; elpa is emacs's package manager, use it to install like geiser slime elpy
;;;geiser is for scheme, slime is for common lisp, and elpy is for python
;;;M-x geiser or M-x run-racket or M-x run-python
;;;the next two lines is for elpy
;;;(package-initialize)
;;;(elpy-enable)

;;; no cursor jump back to the mark position when use M-w
(global-set-key (kbd "M-w") 'copy-region-as-kill)

(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;;; store erc log into ~/erc-log/
(require 'erc-log)
(erc-log-mode 1)
(setq erc-log-channels-directory "~/erc-log/"
      erc-save-buffer-on-part t
      erc-log-file-coding-system 'utf-8)
      ;;;erc-log-write-after-send t
      ;;;erc-log-write-after-insert t)
 
(unless (file-exists-p erc-log-channels-directory)
  (mkdir erc-log-channels-directory t))
