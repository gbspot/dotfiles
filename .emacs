(custom-set-variables
 '(inhibit-startup-screen t))

(add-to-list 'load-path "~/.emacs.d/site-lisp")

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
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/popup-el")
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on
;;; tab key, if the word exists in yasnippet, pressing tab will cause
;;; yasnippet to activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

(add-to-list 'load-path "~/.emacs.d/auto-complete-clang")
(require 'auto-complete-clang)

(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)

(setq x-alt-keysm 'meta)

(set-face-attribute 'default nil :height 150)

; ------------------------
; member-functions (C++)
; ------------------------
(require 'member-functions)
(setq mf--source-file-extension "cpp")


; --------------
; color-theme
; --------------
; Not bundled on emacs for mac
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

; --------
; magit
; --------
(add-to-list 'load-path "~/.emacs.d/dash.el")
(add-to-list 'load-path "~/.emacs.d/magit/lisp")
(require 'magit)



(tool-bar-mode -1)
