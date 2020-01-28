;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;	setup coding system and window property
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(prefer-coding-system 'utf-8)
(setenv "LANG" "en_US.UTF-8")
(setenv	"LC_ALL" "en_US.UTF-8")
(setenv	"LC_CTYPE" "en_US.UTF-8")


(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)


					; file edit settings
(setq tab-width 4 inhibit-splash-screen t initial-scratch-message nil sentence-end-double-space nil
      make-backup-files nil indent-tabs-mode nil make-backup-files nil auto-save-default nil)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;	operation system settings
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(cond ((string-equal system-type "darwin") 
       (progn
	 ;; modify option and command key
	 (setq mac-command-modifier 'control) 
	 (setq mac-option-modifier 'meta)

	 ;; batter copy and paste support for mac os x
	 (defun copy-from-osx () 
	   (shell-command-to-string "pbpaste")) 
	 (defun paste-to-osx (text &optional push) 
	   (let ((process-connection-type nil)) 
	     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy"))) 
	       (process-send-string proc text) 
	       (process-send-eof proc)))) 
	 (setq interprogram-cut-function 'paste-to-osx) 
	 (setq interprogram-paste-function 'copy-from-osx) 
	 (message "Wellcome To Mac OS X, Have A Nice Day!!!"))))

(use-package 
  exec-path-from-shell)
(when (memq window-system '(mac ns x)) 
  (exec-path-from-shell-initialize))


;;(use-package solarized-theme
;;   :config
;;   (load-theme 'solarized-dark t))



;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;	coding font for english and chinese
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(set-face-attribute 'default nil 
		    :family "Monaco")



;;去掉不需要展示的 minor-mode
;;; Use Miminish minor modes to change the mode line

(use-package 
  diminish 
  :ensure t 
  :demand t 
  :diminish hs-minor-mode 
  :diminish abbrev-mode 
  :diminish auto-revert-mode 
  :diminish auto-fill-function 
  :diminish mail-abbrevs-mode 
  :diminish highlight-indentation-mode 
  :diminish subword-mode)

;;; Stolen From https://github.com/hrs/dotfiles/blob/master/emacs.d/configuration.org
(defmacro diminish-minor-mode (filename mode &optional abbrev) 
  "Macro for diminish minor mode with FILENAME MODE and ABBREV."
  `(eval-after-load (symbol-name ,filename) 
     '(diminish ,mode ,abbrev)))

(defmacro diminish-major-mode (mode-hook abbrev) 
  "Macro for diminish major mode with MODE-HOOK and ABBREV."
  `(add-hook ,mode-hook (lambda () 
			  (setq mode-name ,abbrev))))
(diminish-minor-mode 'highlight-indentation 'highlight-indentation-mode )
(diminish-minor-mode 'mail-abbrevs 'mail-abbrevs-mode )
(diminish-minor-mode 'auto-revert 'auto-revert-mode)
(diminish-minor-mode 'simple 'auto-fill-function )
(diminish-minor-mode 'eldoc 'eldoc-mode)
(diminish-major-mode 'emacs-lisp-mode-hook "Elisp")
(diminish-major-mode 'lisp-interaction-mode-hook "Lisp")
(diminish-major-mode 'python-mode-hook "Py")



(custom-set-faces '(mode-line ((t 
				(:background "dark blue" 
					     :foreground "white")))))


;;;;; customize mode line
;;(setq-default mode-line-format '("["
;;				 "%e"
;;				 (:eval
;;				  (window-numbering-get-number-string))
;;				 "]"
;;				 mode-line-front-space
;;				 mode-line-mule-info
;;				 ;; mode-line-client
;;				 ;; mode-line-modified -- show buffer change or not
;;				 ;; mode-line-remote -- no need to indicate this specially
;;				 ;; mode-line-frame-identification -- this is for text-mode emacs only
;;				 "["
;;				 mode-name
;;				 " :"
;;				 mode-line-buffer-identification
;;				 "]"
;;				 " "
;;				 mode-line-position
;;				 (vc-mode vc-mode)
;;				 " "
;;				 ;; mode-line-modes -- move major-name above
;;				 "["
;;				 minor-mode-alist
;;				 "]"
;;				 mode-line-misc-info
;;				 ;; mode-line-end-spaces
;;				 ))
;;


;; highlight current line
(if (display-graphic-p)

    (setq initial-frame-alist '((background-color . "honeydew"))) 
  (setq initial-frame-alist '( (tool-bar-lines . 0))))

(setq default-frame-alist initial-frame-alist)




(provide 'appearance)
