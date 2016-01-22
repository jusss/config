;;; for reading, run `emacs -q -l reading.el` will read reading.el as startup file not ~/.emacs
;;; C-h a read-only RET get C-x C-q will change the current buffer to read-only mode, or you can change the file to read-only with chmod command
;;; emacs config for archlinux

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
		  (erc :server "irc.freenode.net" 
			   :port 6665 
			   :nick "xxxx" 
			   :full-name "xxxxxxx" 
			   :password "")
		  (setq erc-autojoin-channels-alist '(("freenode.net"
						       "#emacs"
						       )))))

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
 '(erc-action-face ((t nil)))
 '(erc-button ((t nil)))
 '(erc-current-nick-face ((t (:foreground "red" :weight bold))))
 '(erc-input-face ((t (:foreground "#004e00"))))
 '(erc-my-nick-face ((t (:foreground "#ff5500" :weight bold))))
 '(erc-nick-default-face ((t nil)))
 '(erc-nick-msg-face ((t (:foreground "red"))))
 '(erc-notice-face ((t (:foreground "SlateBlue"))))
 '(erc-timestamp-face ((t (:foreground "green"))))
 '(ido-first-match ((t nil)))
 '(mode-line ((t (:background "snow" :foreground "forest green" :box (:line-width -1 :style released-button)))))
 '(mode-line-buffer-id ((t nil))))
(set-background-color "#e7f4fe")
(set-foreground-color "#004e00")
(set-face-foreground 'fringe "#e7f4fe")
(set-face-background 'fringe "#e7f4fe")
(setq gnus-asynchronous t)
(setq gnus-use-cache t)
(global-set-key (kbd "C-'") 'gnus)

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

