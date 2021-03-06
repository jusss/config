;emacs config for archlinux

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
		  (erc-ssl :server "morgan.freenode.net" 
			   :port 6697 
			   :nick "jusss" 
			   :full-name "xxxxxxx" 
			   :password "xxx")
		  (setq erc-autojoin-channels-alist '(("freenode.net" 
						       "#emacs")))
		  (setq erc-autojoin-timing 'ident)))

(show-paren-mode t)
(setq completion-ignore-case t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-action-face ((t nil)))
 '(erc-button ((t nil)))
 '(erc-current-nick-face ((t (:foreground "red" :weight bold))))
 '(erc-input-face ((t (:foreground "#6a5acd"))))
 '(erc-my-nick-face ((t (:foreground "#ff5500" :weight bold))))
 '(erc-nick-default-face ((t nil)))
 '(erc-nick-msg-face ((t (:foreground "red"))))
 '(erc-notice-face ((t (:foreground "SlateBlue"))))
 '(erc-timestamp-face ((t (:foreground "green"))))
 '(ido-first-match ((t nil)))
 '(mode-line-buffer-id ((t nil)))
 '(mode-line ((t (:background "DarkSlateGray4" :foreground "black" :box (:line-width -1 :style released-button))))))
(set-background-color "#e7f4fe")
(set-foreground-color "#6a5acd")

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
