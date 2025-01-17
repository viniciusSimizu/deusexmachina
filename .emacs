(setq custom-file "~/.emacs.d/custom.el"
	  lsp-keymap-prefix "s-x")

(setq-default inhibit-splash-screen t
			  make-backup-files nil
			  tab-width 4)

(add-to-list 'default-frame-alist '(font . "Hack Nerd Font-12"))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(ido-mode 1)
(ido-everywhere 1)
(global-display-line-numbers-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(load-theme 'catppuccin :no-confirm)
(load custom-file)
;; Q