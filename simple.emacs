; emacs -q --load simple.emacs
; package install auto-complete and haskell-mode
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq confirm-nonexistent-file-or-buffer nil)
(ido-mode t)
(global-set-key (kbd "C-,") 'ido-switch-buffer)
(global-set-key (kbd "C-;") 'set-mark-command)
(global-set-key (kbd "C-'") 'pop-to-mark-command)
(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "<f12>") 'ido-switch-buffer)
(global-set-key (kbd "<f9>") 'set-mark-command)
(global-set-key (kbd "<f8>") 'pop-to-mark-command) ;;; there's also pop-global-mark
(global-set-key (kbd "M-;") 'set-mark-command)
(global-set-key (kbd "C-x C-;") 'pop-global-mark)
(global-set-key (kbd "M-w") 'copy-region-as-kill)
(show-paren-mode t)
(setq completion-ignore-case t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

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

(display-time-mode 1)

;;; disable auto fill mode, if it enable, input like 'a b RET c', it maybe change to 'a RET b c', special when you're composing mail in gnus
(add-hook 'message-mode-hook 'turn-on-auto-fill)

(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(require 'package)
(package-initialize)

; M-x package-refresh-contents
; M-x package-install RET ox-pandoc RET

(require 'auto-complete)
(add-to-list 'ac-modes 'javascript-mode)
(add-to-list 'ac-modes 'elm-mode)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'css-mode)
(add-to-list 'ac-modes 'python-mode)
(add-to-list 'ac-modes 'racket-mode)
(add-to-list 'ac-modes 'scheme-mode)
(add-to-list 'ac-modes 'js-mode)
(add-to-list 'ac-modes 'mhtml-mode)
(add-to-list 'ac-modes 'haskell-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'fundamental-mode)
(ac-config-default)
;;; auto-complete perfer upper case, but I want lower case, so ignore case
(setq ac-ignore-case nil)


(require 'haskell-mode)

;;; (linum-mode 1)
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
;;; since 26.1 display-line-numbers-mode replace linum-mode
(dolist (hook '(python-mode-hook
                javascript-mode-hook
                html-mode-hook
                mhtml-mode-hook
                css-mode-hook
                haskell-mode-hook
		c-mode-common-hook))
  (add-hook hook (lambda () (display-line-numbers-mode t))))

(require 'tramp)
(customize-set-variable
           'tramp-ssh-controlmaster-options
           (concat
             "-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
             "-o ControlMaster=auto -o ControlPersist=yes"))

(defun unword (alst)
  (reduce (lambda (x y) (concat x y)) (mapcar (lambda (x) (concat x " ")) alst)))

(defun my-python-compile2 () 
  (interactive)
  (run-code "python" "" "" "*Another Shell Buffer*"))

(defun my-python-compile ()
  (interactive)
  (run-code "python" "" "" "*Async Shell Command*"))

(defun my-haskell-compile2 () 
  (interactive)
  (run-code "python" "" "" "*Another Shell Buffer*"))

(defun my-haskell-compile () 
  (interactive)
  (run-code "runghc" "" "" "*Async Shell Command*"))

;;; (run-code "runghc" "-f /usr/bin/ghc" "a.conf" "another-shell-buffer")
;;; this will run as "runghc -f /usr/bin/ghc tmp-file.hs a.conf "
(defun run-code (run-cmd pre-parameter rest-parameter async-buffer-name)
  "(run-code 'runghc' '-f /usr/bin/ghc' 'a.conf' 'another-shell-buffer')
   this will run as 'runghc -f /usr/bin/ghc current-buffer.hs.tmp a.conf'"
  (interactive)
  (if (string-match "^/ssh:.*?:" (buffer-file-name (current-buffer)))
      ;;; if tramp-mode on remote
      (progn
        (write-region (point-min) (point-max) (concat (buffer-file-name) ".tmp"))
        (setq tmp-file (concat
              (substring (buffer-file-name) 
                         (+ 1 (string-match ":/.*" (buffer-file-name)))
                         (length (buffer-file-name)))
              ".tmp"))
        )
      ;;; on local
      (progn (setq tmp-file (concat (buffer-file-name) ".tmp"))
             (write-region (point-min) (point-max) tmp-file)))
  (let* ((another-shell-buffer (get-buffer-create async-buffer-name))
         (proc (progn
                 (async-shell-command (unword `(,run-cmd ,pre-parameter ,tmp-file ,rest-parameter)) another-shell-buffer)
                 (switch-to-buffer-other-window another-shell-buffer)
                 (get-buffer-process another-shell-buffer))))
    (if (process-live-p proc)
        (set-process-sentinel proc #'after-async-done)
      (message "No process running."))))

(defun after-async-done (process signal)
  (when (memq (process-status process) '(exit signal))
    (back-to-code-buffer)
    (shell-command-sentinel process signal)))

(defun back-to-code-buffer ()
  (interactive)
  (switch-to-buffer-other-window 
   (substring (car (last (split-string tmp-file "/"))) 0 -4)))

;;; https://emacs.stackexchange.com/questions/42172/run-elisp-when-async-shell-command-is-done
;;; https://stackoverflow.com/questions/34857843/kill-emacss-async-shell-command-buffer-if-command-is-terminated

(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "<f5>") 'my-python-compile)
            (local-set-key (kbd "<f6>") 'my-python-compile2)
            (local-set-key (kbd "C-c r") 'my-python-compile)
            (local-set-key (kbd "C-c e") 'my-python-compile2)
            (setq-local eldoc-documentation-function #'ignore)
))

;;; in tramp-mode buffer, M-x shell RET, will open remote shell
(electric-indent-mode -1)
(add-hook 'haskell-mode-hook
	  (lambda () (local-set-key (kbd "<f5>") 'my-haskell-compile)
            (local-set-key (kbd "<f6>") 'my-haskell-compile2)
            (local-set-key (kbd "C-c r") 'my-haskell-compile)
            (local-set-key (kbd "C-c e") 'my-haskell-compile2)
            (haskell-indentation-mode -1)
            (haskell-indent-mode -1) ;;; just won't work, I don't know why
))
;;; http://haskell.github.io/haskell-mode/manual/latest/Indentation.html#Indentation
;;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;;; M-x package-install haskell-mode     C-c C-l will eval code in interpreter
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;; (add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

(setq compilation-save-buffers-predicate '(lambda () nil))
(setq compilation-always-kill t)

;;; Shift-Tab back for four whitespace
(defun back-by-4 () (interactive)
     ;;;(backward-delete-char-untabify 4)
     (backward-char 4)
)

(global-set-key (kbd "<S-iso-lefttab>") 'back-by-4)
(global-set-key (kbd "<S-tab>") 'back-by-4)

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

;;; use spaces instead of tabs, https://www.emacswiki.org/emacs/NoTab
(setq-default indent-tabs-mode nil)

;;; switch-window ace-window
(global-set-key (kbd "C-x o") 'ace-window)

(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/.*\.py\'" . python-mode)) auto-mode-alist))
