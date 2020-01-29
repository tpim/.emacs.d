;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;	Setup pkg repo and install use-package
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(require 'package)
(setq package-enable-at-startup nil)

(unless (assoc-default "melpa" package-archives) 
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))



(unless (assoc-default "org" package-archives) 
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))
(unless (assoc-default "marmalade" package-archives) 
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package) 
  (package-refresh-contents) 
  (package-install 'use-package))

(eval-when-compile 
  (require 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)

;; Basic packages

(use-package 
  smartparens 
  :init (require 'smartparens-config) 
  (add-hook 'lisp-mode-hook #'smartparens-mode) 
  (add-hook 'c++-mode-hook #'smartparens-mode) 
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode))



(use-package 
  rainbow-delimiters 
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


;; (use-package
;;   evil
;;   :init (evil-mode 1))


(use-package 
  lsp-mode 
  :config (add-hook 'c++-mode-hook #'lsp) 
  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error")) 
  (setq lsp-prefer-flymake nil) ;; Prefer using lsp-ui (flycheck) over flymake.
  )

(use-package 
  lsp-ui 
  :requires lsp-mode 
  flycheck 
  :config (setq lsp-ui-doc-enable t lsp-ui-doc-use-childframe t lsp-ui-doc-position 'top
		lsp-ui-doc-include-signature t lsp-ui-sideline-enable nil lsp-ui-flycheck-enable t
		lsp-ui-flycheck-list-position 'right lsp-ui-flycheck-live-reporting t
		lsp-ui-peek-enable t lsp-ui-peek-list-width 60 lsp-ui-peek-peek-height 25) 
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))


(use-package 
  company 
  :config (setq company-idle-delay 0.1) 
  (global-company-mode 1) 
  (global-set-key (kbd "C-<tab>") 'company-complete))

(use-package 
  company-lsp 
  :requires company 
  :config (push 'company-lsp company-backends)

  ;; Disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil))


(use-package 
  recentf 
  :config (recentf-mode +1) 
  :bind (("C-x C-r" . recentf-open-files)))



;; Xah-fly-key
(use-package 
  xah-fly-keys 
  :ensure t 
  :config (xah-fly-keys-set-layout "qwerty") ; required

  ;; possible layout values:

  ;; "azerty"
  ;; "azerty-be"
  ;; "colemak"
  ;; "colemak-mod-dh"
  ;; "dvorak"
  ;; "programer-dvorak"
  ;; "qwerty"
  ;; "qwerty-abnt"
  ;; "qwertz"
  ;; "workman"
  ;; "norman"
  (xah-fly-keys 1))











(use-package 
  clang-format 
  :ensure t 
  :commands (clang-format-buffer))


(defun my-c-mode-setup () 
  (add-hook 'before-save-hook 'clang-format-buffer))

(add-hook 'c-mode-hook 'my-c-mode-setup)
(add-hook 'c++-mode-hook 'my-c-mode-setup)



;; auto format elisp code when saving.
(use-package 
  elisp-format 
  :ensure t)
(defun my-elisp-mode-setup() 
  (add-hook 'before-save-hook 'elisp-format-buffer))
(add-hook 'emacs-lisp-mode-hook 'my-elisp-mode-setup)


(use-package 
  which-key 
  :defer 10 
  :config (progn 
	    (setq which-key-popup-type 'side-window) ;Default
	    ;; (setq which-key-popup-type 'minibuffer)
	    (setq which-key-compute-remaps t) ;Show correct descriptions for remapped keys
	    (which-key-mode 1)))

(use-package 
  multiple-cursors)


(global-set-key (kbd "C-s->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-s-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-c a") 'mc/mark-all-like-this)


(defun my-xfk-addon-command() 
  "add/change keys for xah-fly-keys command mode keys" 
  (interactive) 
  (define-key xah-fly-key-map (kbd "b") 'mc/edit-lines) 
  (define-key xah-fly-key-map (kbd "M-x") 'counsel-M-x) 
  (define-key xah-fly-key-map (kbd "M-n") 'neotree-toggle)
  ;; more here
  )
(defun my-xfk-addon-insert() 
  "add/change keys for xah-fly-keys command mode keys" 
  (interactive) 
  (define-key xah-fly-key-map (kbd "M-x") 'xah-fly-command-mode-activate)
  ;; more here
  )


(add-hook 'xah-fly-command-mode-activate-hook 'my-xfk-addon-command)

(add-hook 'xah-fly-insert-mode-activate-hook 'my-xfk-addon-insert)


;; Ivy/Counsel/Swiper
(use-package 
  ivy 
  :diminish (ivy-mode . "") 
  :init (ivy-mode 1) 
  :config (setq ivy-use-virtual-buffers t) 
  (setq ivy-height 20) 
  (setq ivy-count-format "%d/%d "))


;; Override the basic build-in Emacs commands
(use-package 
  counsel 
  :bind*				; load when pressed
  (("C-s"     . swiper) 
   ("C-x C-f" . counsel-find-file) 
   ("C-x C-r" . counsel-recentf)       ; search for recently edited
   ("C-c g"   . counsel-git)	       ; search for files in git repo
   ("C-c j"   . counsel-git-grep)      ; search for regexp in git repo
   ("C-c /"   . counsel-ag)	       ; Use ag for regexp
   ("C-x l"   . counsel-locate) 
   ("C-x C-f" . counsel-find-file) 
   ("<f1> f"  . counsel-describe-function) 
   ("<f1> v"  . counsel-describe-variable) 
   ("<f1> l"  . counsel-find-library) 
   ("<f2> i"  . counsel-info-lookup-symbol) 
   ("<f2> u"  . counsel-unicode-char) 
   ("C-c C-r" . ivy-resume)))	    ; Resume last Ivy-based completion

(use-package 
  magit 
  :ensure t)

(use-package 
  ag)



(use-package 
  projectile 
  :ensure t 
  :bind* (("M-s p" . counsel-projectile-switch-project)) 
  :config
  ;; Global configuration
  (setq projectile-switch-project-action 'neotree-projectile-action projectile-enable-caching
	t projectile-create-missing-test-files t projectile-switch-project-action
	#'projectile-commander projectile-ignored-project-function 'file-remote-p)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  ;; Register custom PHP project type
  (projectile-register-project-type 'php '("composer.json") 
				    :src-dir "src" 
				    :test "composer test" 
				    :run "composer serve" 
				    :test-suffix "Test" 
				    :test-dir "tests"))
(use-package 
  counsel-projectile 
  :ensure t)









(use-package 
  neotree 
  :ensure t 
  :config
  ;; Every time when the neotree window is opened, let it find current file and jump to node.
  (setq neo-smart-open t)
  ;; Do not autorefresh directory to show current file
  (setq neo-autorefresh nil))


;; Company language package for PHP
(use-package 
  company-php 

  :defer 
  :after company)




(provide 'base)
