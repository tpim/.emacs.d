(add-to-list 'load-path "~/.emacs.d/core/conf")

(require 'conf)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (counsel ivy multiple-cursors xah-fly-keys which-key use-package
					     solarized-theme smartparens rainbow-delimiters lsp-ui
					     exec-path-from-shell evil elisp-format diminish
					     company-lsp clang-format))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t 
	       (:background "dark blue" 
			    :foreground "white")))))
