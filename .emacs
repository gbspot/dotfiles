(add-to-list 'load-path "/home/blucherg/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/blucherg/.emacs.d/ac-dict")
(ac-config-default)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


(setq x-alt-keysm 'meta)

(set-face-attribute 'default nil :height 150)

(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

(tool-bar-mode -1)
