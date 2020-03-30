﻿(ido-mode t)
(global-set-key (kbd "C-,") 'ido-switch-buffer)
(global-set-key (kbd "C-;") 'set-mark-command)
(global-set-key (kbd "C-x C-;") 'pop-global-mark)

;;;for auto-complete (ac-config-default)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'auto-complete)
;(require 'ac-slime)
(add-to-list 'ac-modes 'javascript-mode) 
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'css-mode)
(add-to-list 'ac-modes 'python-mode)
;(add-to-list 'ac-modes 'slime-mode)
(add-to-list 'ac-modes 'scheme-mode)
(add-to-list 'ac-modes 'mhtml-mode)
(add-to-list 'ac-modes 'js-mode)
(add-to-list 'ac-modes 'elm-mode)
(add-to-list 'ac-modes 'haskell-mode)
(ac-config-default)
;(add-hook 'slime-mode-hook 'set-up-slime-ac)
;(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;(eval-after-load "auto-complete"
 ;'(add-to-list 'ac-modes 'slime-repl-mode))

 (show-paren-mode t)
 (setq completion-ignore-case t)
 (setq confirm-nonexistent-file-or-buffer nil)
 (setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(menu-bar-mode -1)

(cd "C:/Users/admin/Desktop")

;;; solve C-v cause page down is stuck 'cause font scan
;;;(set-face-attribute 'default nil :family "SimSun" :height 100)
;;; ;; Setting Chinese Font
;;;(dolist (charset '(kana han symbol cjk-misc bopomofo))
 ;;; (set-fontset-font (frame-parameter nil 'font)
  ;;          charset
  ;;          (font-spec :family "Microsoft Yahei " :size 14)))

;;; unicode characters
;;;(set-default-font "Microsoft YaHei UI Bold-10")
;;;(set-fontset-font "fontset-default"  
;;;                  'gb18030' ("Microsoft YaHei UI Bold" . "unicode-bmp"))
(require 'unicode-fonts)
(unicode-fonts-setup)
;;;(set-default-font "微软雅黑 Bold-10")
;(set-default-font "Consolas Bold-10")
;;; just set it by emacs's menu-bar 
;(set-default-font "Fira Mono Regular-10")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (haskell-tab-indent lsp-mode hlint-refactor haskell-emacs ace-window haskell-mode elm-mode unicode-fonts tabbar ## twittering-mode ac-slime)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Mono" :foundry "outline" :slant normal :weight normal :height 100 :width normal)))))
(require 'tabbar)
(tabbar-mode 1)
(global-set-key [(meta p)] 'tabbar-backward)
(global-set-key [(meta n)] 'tabbar-forward)
(setq tabbar-use-images nil)

;;; group all buffers into 3 groups, ERC, * and use buffer
(defun tabbar-buffer-groups ()
  (list
   (cond
    ((string-equal "*" (substring (buffer-name) 0 1))
     "Emacs Buffer"
     )
    ((eq major-mode 'erc-mode)
     "ERC"
     )
    (t
     "User Buffer"
     )
    ))) 

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;;;<b> erc-mode . You can tell for yourself if you're using erc: go into an
;;; erc buffer and C-h v major-mode RET

(set-face-attribute 'tabbar-default nil
		    :family "SimSun"
		    :height 106
		    :background "grey80"
		    :foreground "purple")

(set-face-attribute 'tabbar-selected nil
		    :inherit 'tabbar-default
		    :foreground "blue"
		    :background "grey80")
			
(setq erc-header-line-format nil)

;;; show line number
;;;display-line-numbers-mode instead of linum-mode since 26.1
;;; https://www.masteringemacs.org/article/whats-new-in-emacs-26-1
;;;M-g g 35
;;; like 35G in vim
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x g") 'goto-line)
;;; like ma in vim
(global-set-key (kbd "C-x p")  'point-to-register)
;;; like 'a in vim
(global-set-key (kbd "C-x j") 'jump-to-register)
;;;like :s/whatever/you-want
(global-set-key (kbd "C-x c") 'replace-regexp)
;;; make linum-mode hook python-mode
(dolist (hook '(python-mode-hook
                javascript-mode-hook
                html-mode-hook
                css-mode-hook
                js-mode
				mhtml-mode
                haskell-mode-hook
		c-mode-common-hook))
(add-hook hook (lambda () (display-line-numbers-mode t))))

;;; python-mode will not eval python buffer if there is threading code
(defun my-python-compile ()
  (interactive)
  (setq tmp-file (concat (buffer-file-name) ".tmp"))
  (write-region (point-min) (point-max) tmp-file)
  (compile (concat "python " tmp-file)))

(add-hook 'python-mode-hook
	  (lambda () (local-set-key (kbd "<f5>") 'my-python-compile)))
      
;;; haskell-mode, runghc will only read .hs file, so suffix with .tmp.hs
;;; ghci will always start a repl, so use runghc
(defun my-haskell-compile ()
  (interactive)
  (setq tmp-file (concat (buffer-file-name) ".tmp.hs"))
  (write-region (point-min) (point-max) tmp-file)
  (compile (concat "runghc " tmp-file)))

(electric-indent-mode -1)
(add-hook 'haskell-mode-hook
	  (lambda () (local-set-key (kbd "<f5>") 'my-haskell-compile)
      (haskell-indentation-mode -1)
      (haskell-indent-mode -1) 
      ;;;just won't work, I don't know why
     ))
;;; http://haskell.github.io/haskell-mode/manual/latest/Indentation.html#Indentation
;;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(setq compilation-save-buffers-predicate '(lambda () nil))
(setq compilation-always-kill t)
;;;make erc work with tabbar
(setq erc-header-line-uses-tabbar-p t)
;;; emacs over socks5
;(setq socks-override-functions 1)
;(setq socks-noproxy '("localhost"))
;(require 'socks)
;(setq socks-server (list "My socks server" "localhost" 7070 5))
;;;https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;; use spaces instead of tabs, https://www.emacswiki.org/emacs/NoTab
(setq-default indent-tabs-mode nil)


;;; auto-complete perfer upper case, but I want lower case, so ignore case
(setq ac-ignore-case nil)
(global-set-key (kbd "C-x o") 'ace-window)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;;(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

;;; Shift-Tab back for four whitespace
(defun jusss/back-by-4 () (interactive)
          ;;;(backward-delete-char-untabify 4)
          (backward-char 4)
)
          
(global-set-key (kbd "<S-tab>") 'jusss/back-by-4)

(defun my-turn-indentation-off ()
  (interactive)
  ;;; disable tab indent
  (local-set-key (kbd "<tab>") 'tab-to-tab-stop)
  ;;; enable indent for previous line
 ;;;(local-set-key (kbd "<tab>") 'indent-relative)
 (setq tab-width 4)
)

;;; disable all the tab indent
(dolist (hook '(perl-mode-hook
                c-mode-hook
                haskell-mode-hook
                java-mode-hook))
  (add-hook hook 'my-turn-indentation-off))