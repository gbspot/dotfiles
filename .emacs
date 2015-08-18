(custom-set-variables
 '(inhibit-startup-screen t))


(add-to-list 'load-path "~/.emacs.d")

;-----------
; editing
;-----------

; No tabs, spaces only
(setq-default indent-tabs-mode nil)


(setq tab-width 2)
(setq c-basic-offset 2)
(setq sh-basic-offset 2)

; ----------------
; auto-complete
;-----------------
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/popup-el")
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(setq x-alt-keysm 'meta)

(set-face-attribute 'default nil :height 150)

(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

(tool-bar-mode -1)
