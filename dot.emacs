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
;;;(transient-mark-mode -1)
(ido-mode t)
(global-set-key (kbd "C-,") 'ido-switch-buffer)
(global-set-key (kbd "C-;") 'set-mark-command)
(global-set-key (kbd "C-'") 'pop-to-mark-command)
(global-set-key (kbd "C-/") 'comment-or-uncomment-region)
(global-set-key (kbd "<f12>") 'ido-switch-buffer)
(global-set-key (kbd "<f9>") 'set-mark-command)
(global-set-key (kbd "<f8>") 'pop-to-mark-command) ;;; there's also pop-global-mark
;;;(global-set-key (kbd "C-x C-;") 'pop-global-mark)
;;;(global-set-key (kbd "C-u C-;") ...)
;;; C-u C-; do the same as C-x C-x return to last marked position in local buffer
;;; C-; C-g can mark without select a block or C-; C-;
;;; C-x C-; can return to last marked position in all buffers
;;;https://www.emacswiki.org/emacs/MarkCommands
;;; C-x r t will put characters into every line's start
;;;(global-set-key (kbd "C-x r e") 'replace-regexp)
;;; emacs -nw in screen, C-; doesn't work, so set M-; as set-mark-command
;;;M-; runs the command comment-dwim, which is an interactive compiled
;;;Lisp function in `newcomment.el'.
(global-set-key (kbd "M-;") 'set-mark-command)
;;; C-u C-; jump to the previous mark position only in local buffer
;;; C-x C-; jump to the previous mark position in global buffer
(global-set-key (kbd "C-x C-;") 'pop-global-mark)

;;; no cursor jump back to the mark position when use M-w
(global-set-key (kbd "M-w") 'copy-region-as-kill)


;os clipboard swap with kill-ring

;(setq interprogram-cut-fucntion 'x-select-text)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;(setq x-select-enable-clipboard t)
;(setq select-active-regions t)
;(setq yank-pop-change-selection t)
;(setq save_interprogram-paste_before-kill t)

(require `erc)
(require `tls)
(global-set-key (kbd "C-x C-.")
		(lambda ()
		  "server ip can't be as variable's type"
		  (interactive)
		  (erc-ssl :server "irc.freenode.net" 
			   :port 7000 
			   :nick "x" 
			   :full-name "x" 
			   :password "x")
		  (setq erc-autojoin-channels-alist '(("x.net"
						       "#x"
						       "#x")))))
;;;		  (setq erc-autojoin-timing 'ident)))
;;; waiting for identify, then join channel

(show-paren-mode t)
(setq completion-ignore-case t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(display-time-mode t)
 '(gnutls-min-prime-bits 2048)
 '(package-selected-packages
   (quote
    (neotree kotlin-mode unicode-emoticons unicode-fonts use-package doom-modeline doom-themes ssh telega lsp-mode ace-window switch-window web-mode haskell-mode w3m elm-mode tabbar python-mode racket-mode auto-complete)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
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
;;;(set-background-color "#e7f4fe")
;;;(set-foreground-color "#004e00")
;;;(set-face-foreground 'fringe "#e7f4fe")
;;;(set-face-background 'fringe "#e7f4fe")
;;; remove erc header-line
(setq erc-header-line-format nil)
(setq gnus-asynchronous t)
(setq gnus-use-cache t)
;;;(global-set-key (kbd "C-'") 'gnus)

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
				      "unaffiliated/john"
				      ))
			message)
    (start-process "erc-notify"
		   "erc-notify"
		   "/usr/bin/env"
		   (concat "DISPLAY=" (getenv "DISPLAY"))
		   ;;;"/home/john/lab2/erc-notifier.py"
		   "/home/john/lab2/erc-notifier.sh"
		   "erc"
		   message)))
;;;if it run at Xorg :1, then change DISPLAY environment, or just comment env and DISPLAY lines

;;; erc and tabbar both use header-line
(setq erc-header-line-uses-tabbar-p t)

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

;;; emacs or erc over socks5 proxy
;;;https://www.emacswiki.org/emacs/ErcProxy
;;;(setq socks-override-functions 1)
;;; (setq socks-noproxy '("localhost"))
;;; (require 'socks)
;;;(setq socks-server (list "My socks server" "localhost" 7070 5))
;;; proxychains emacs is a better choice

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
;;(require 'w3m-load)

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


;;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;;; M-x describe-variable load-path or load-path C-j in *scratch* get the emacs load directory
;;;mkdir ~/multi-term
;;;copy https://www.emacswiki.org/emacs/download/multi-term.el to ~/multi-term/
;;;multi-term https://www.emacswiki.org/emacs/MultiTerm
;;; also have term and ansi-term mode, C-c C-j turn to line that you can yank with C-y
;;; C-c C-k turn to char just like normal termianl emulator, but in multi-term you don't need that
;;; just do whatever you want in multi-term like in emacs
(add-to-list 'load-path "~/.emacs.d/multi-term")
;;;(require 'multi-term)
(setq multi-term-program "/bin/bash")
;;; set key to switch termianl buffers
;;; http://blog.jobbole.com/51598/  more details see ~/.emacs.d/multi-term/multi-term.el
(add-hook 'term-mode-hook
	  (lambda()
	    (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
	    (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))
;;; set buffer's maximum line, 0 means no limit
;;; (add-hook 'term-mode-hook
;;;     (lambda ()
;;;          (setq term-buffer-maximum-size 4096)))
;;; you can turn off some minor mode (major mode, minor mode), put some function
;;; into mode's hook to disable some function like (auto-fill-mode -1) disable auto-fill-mode in minor mode
;;; (add-hook 'term-mode-hook
;;;     (lambda ()
;;;         (setq show-trailing-whitespace nil)
;;;         (autopair-mode -1)))
;;; ("M-p" . term-send-up) ("M-n" . term-send-down) same like C-p C-n in normal terminal emulator
;;; but fvwm2 use M-p M-n too, and fvwm2 use M-2 M-number to conflict with emacs's M-number C-n, fuck!
;;; emacs use C-u number C-n to instead M-number C-n, and set ("C-c C-p" . term-send-up) in ~/.emacs.d/multi-term/multi-term.el
;;; not any more! I have changed key bind in fvwm2, window-p instead of M-p, window-number instead of M-number
;;; use M-number C-n in emacs and M-p in multi-term

;;; elscreen https://www.emacswiki.org/emacs/EmacsLispScreen
;;; git clone 'https://github.com/shosti/elscreen.git'
;;; save it to ~/.emacs.d/elscreen/elscreen.el
;;; or download from ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/
;;;  change it by setting elscreen-prefix-key
;;; (setq elscreen-prefix-key (kbd "C-."))
;;; You must set this value before ElScreen is loaded otherwise use elscreen-set-prefix-key
(add-to-list 'load-path "~/.emacs.d/elscreen")
;;;(require 'elscreen)
;;;(elscreen-start)
;;;(elscreen-set-prefix-key (kbd "C-."))
;;; if you want auto run elscree then put (elscreen-start) in ~/.emacs
;;; M-x elscreen-start to run elscreen
;;; M-x elscreen-create to create new screen
;;; read the Readme.md from elscreen.git, C-z c create new screen, C-z n  next,
;;; C-z p previous, C-z T toggle display, C-z k kill
;;; C-z C-f Create new screen and open file.
;;; C-z C-r Create new screen and open file but don't allow changes.
;;; C-z d Create new screen and run dired.

;;; emacs have melpa for package manager, similar to el-get
;;;M-x list-packages RET
;;; find what you need then move cursor to install and press enter
; (require 'package)
; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
; (add-to-list 'package-archives
		 ; '("melpa" . "http://melpa.milkbox.net/packages/") t)
; (package-initialize)


(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(require 'package)
; this package-initialize only need to call once and only  after setq package-archives in .emacs
(package-initialize)

; M-x package-refresh-contents
; M-x package-install RET ox-pandoc RET




;;; git clone https://github.com/dimitri/el-get.git
;;; cp it to ~/.emacs.d/
;;; M-x el-get-install RET elscreen
;;(add-to-list 'load-path "~/.emacs.d/el-get-master")
;;(require 'el-get)

;;; ignore mouse
;;;(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]    
;;;             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]  
;;;             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]  
;;;             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]  
;;;             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))  
;;;  (global-unset-key k))  
;;;
;;;https://github.com/auto-complete/auto-complete
;;;M-x package-install RET auto-complete RET
;;; if there're other errors like ac-update-greedy, try re-instal popup with package-install and yasnippet
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
; just add the major-mode to the list, ac will work
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'org-mode)
; for all major-mode, like Object in Java
(add-to-list 'ac-modes 'fundamental-mode)
(ac-config-default)
;;; auto-complete perfer upper case, but I want lower case, so ignore case
(setq ac-ignore-case nil)


;;; M-x desktop-save ; desktop-save-mode only save all buffers that have file names, re-open via M-x desktop-read
;;;(desktop-save-mode 1)
;;;M-x package-install tabbar

;; https://www.emacswiki.org/emacs/TabBarMode
;;; set all files show on tabbar
;;;(setq tabbar-buffer-groups-function
;;;      (lambda ()
;;;	(list "ALL")))
;;;(lambda nil (list "ALL"))

(require 'tabbar)
(tabbar-mode 1)

;;; use M-p and M-n to switch the buffers, but when it's in auto-complete mode
;;; M-p and M-n can choose the word you want to instead of left or right arrow

(global-set-key [(meta p)] 'tabbar-backward)
(global-set-key [(meta n)] 'tabbar-forward)
(setq tabbar-use-images nil)

;;; group all buffers into 5 groups, *, ERC, Python, Haskell and others
(defun tabbar-buffer-groups ()
  (list
   (cond ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs Buffer")  
         ((eq major-mode 'erc-mode)  "ERC")
         ((eq major-mode 'python-mode) "Python")
         ((eq major-mode 'mhtml-mode) "Python")
         ((eq major-mode 'css-mode) "Python")
         ((eq major-mode 'js-mode) "Python")
         ((eq major-mode 'haskell-mode) "Haskell")
         (t "User Buffer")
 )))

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;;;<b> erc-mode . You can tell for yourself if you're using erc: go into an
;;; erc buffer and C-h v major-mode RET


;;;(set-face-attribute 'tabbar-default nil :family "SimSun" :height 106 :box nil :background "grey80" :foreground "purple")
;;;(set-face-attribute 'tabbar-selected nil :inherit 'tabbar-default :foreground "blue" :background "grey80")

(set-face-attribute 'tabbar-default nil :background "gray20" :foreground "gray60" :distant-foreground "gray50" :family "Helvetica Neue" :box nil :height 150)
(set-face-attribute 'tabbar-unselected nil :background "gray20" :foreground "black" :box nil)
(set-face-attribute 'tabbar-modified nil :foreground "red4" :box nil :inherit 'tabbar-unselected)
;;;(set-face-attribute 'tabbar-selected nil :background "#4466aa" :foreground "black" :box nil)
(set-face-attribute 'tabbar-selected nil :background "gray20" :foreground "#4466aa" :box nil)
;;;(set-face-attribute 'tabbar-selected-modified nil :inherit 'tabbar-selected  :box nil :background "#4466aa" :foreground "black")
(set-face-attribute 'tabbar-selected-modified nil :inherit 'tabbar-selected  :box nil :background "gray20" :foreground "#4466aa")
(set-face-attribute 'tabbar-button nil :box nil)
(customize-set-variable 'tabbar-separator '(1.5))
(customize-set-variable 'tabbar-use-images nil)
(customize-set-variable 'tabbar-background-color "gray20")
(customize-set-variable 'tabbar-separator '(0.5))
(customize-set-variable 'tabbar-use-images nil)

;;;(set-face-background 'mode-line          "#4466aa")
;;;(set-face-foreground 'mode-line          "black")
(set-face-background 'mode-line          "gray20")
(set-face-foreground 'mode-line          "#4466aa")
;;;(set-face-background 'mode-line          "gray20")
;;;(set-face-background 'mode-line-inactive "#99aaff")
(set-face-background 'mode-line-inactive "gray20")
(set-face-foreground 'mode-line-inactive "#4466aa")
;;;(set-face-background 'fringe "#809088")


;;; highlight color for selected text, set-mark color
(set-face-attribute 'region nil :background "yellow")

;;; show line number
;;;(linum-mode 1)
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

;;;(require 'web-mode)
;;; specify the major mode when open specific file
;;;(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . mhtml-mode))
(setq web-mode-enable-current-element-highlight t)
;;;(setq web-mode-enable-current-column-highlight t)

;;;(set-default-font "Droid Sans-12")
;;;(set-fontset-font "fontset-default" 'gb18030' ("微软雅黑" . "unicode-bmp"))

;;; fonts settings begin
;;;(set-face-attribute 'default nil :font "Fira Mono Medium")
(set-face-attribute 'default nil :font "Delugia Nerd Font:size=20")
;;;(set-face-attribute 'default nil :font "Cascadia Code")
;;;(set-face-attribute 'default nil :font "CamingoCode")
(set-fontset-font t 'han "WenQuanYi WenQuanYi Bitmap Song")
;;;(set-fontset-font t 'latin "Noto Sans")
;;; C-h h point on character, M-x describe-char get the font name
;;; fc-list show all the fonts name
;;; https://idiocy.org/emacs-fonts-and-fontsets.html
;;; fonts settings end

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
            (local-set-key (kbd "C--") 'comment-or-uncomment-region)
            (setq-local eldoc-documentation-function #'ignore)
))

;;; in tramp-mode buffer, M-x shell RET, will open remote shell

(electric-indent-mode -1)
(add-hook 'haskell-mode-hook
	  (lambda () (local-set-key (kbd "<f5>") 'my-haskell-compile)
            (local-set-key (kbd "<f6>") 'my-haskell-compile2)
            (local-set-key (kbd "C-c r") 'my-haskell-compile)
            (local-set-key (kbd "C-c e") 'my-haskell-compile2)
            (local-set-key (kbd "C--") 'comment-or-uncomment-region)
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
(defun jusss/back-by-4 () (interactive)
     ;;;(backward-delete-char-untabify 4)
     (backward-char 4)
)

(global-set-key (kbd "<S-iso-lefttab>") 'jusss/back-by-4)
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

;;; use spaces instead of tabs, https://www.emacswiki.org/emacs/NoTab
(setq-default indent-tabs-mode nil)


;;; switch-window ace-window
(global-set-key (kbd "C-x o") 'ace-window)

;;; doom-themes
;(use-package doom-themes :config
;;;   ;; Global settings (defaults)
;   (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
;         doom-themes-enable-italic nil) ; if nil, italics is universally disabled
;   (load-theme 'doom-dark+ t))
 
;; Enable flashing mode-line on errors
;(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
;;(doom-themes-neotree-config)
;; or for treemacs users
;;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;;(doom-themes-treemacs-config)
  
;; Corrects (and improves) org-mode's native fontification.
;;(doom-themes-org-config))

;;; telega begin
;(add-to-list 'load-path "/snap/telega/current/share/emacs/site-lisp/telega/")
;(require 'telega)
;(setq exec-path (append exec-path '("/var/lib/snapd/snap/bin")))
;(setq telega-proxies (list '(:server "127.0.0.1" :port 1080 :enable t
;                                       :type (:@type "proxyTypeSocks5"))))
;;; telega end

;;; unicode fonts begin
;;; M-x package-install unicode-fonts RET
(require 'unicode-fonts)
; just run unicode-fonts-setup once, then comment it
;;;(unicode-fonts-setup)
;;; unicode fonts end


(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/.*\.py\'" . python-mode)) auto-mode-alist))

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;;; package-install neotree, use f8 to toggle neotree, cd your main directory, then f8, it will expand this directory as file tree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
