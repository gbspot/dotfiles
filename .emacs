(custom-set-variables
 '(inhibit-startup-screen t))

(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; For homebrew packages on OSX
(add-to-list 'exec-path "/usr/local/bin")

;; ----------
;; editing
;; ----------

;; No tabs, spaces only
(setq-default indent-tabs-mode nil)


(setq tab-width 2)
(setq c-basic-offset 2)
(setq sh-basic-offset 2)

(require 'ido)
(ido-mode t)

;; ----------------
;; auto-complete
;; ----------------
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

;; ------------------------
;; member-functions (C++)
;; ------------------------
(require 'member-functions)
(setq mf--source-file-extension "cpp")


;; --------------
;; color-theme
;; --------------
;; Not bundled on emacs for mac
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

;; --------
;; magit
;; --------
(global-set-key (kbd "C-x g") 'magit-status)
(add-to-list 'load-path "~/.emacs.d/dash.el")
(add-to-list 'load-path "~/.emacs.d/magit/lisp")
(require 'magit)


;; ----------
;; spelling
;; ----------
(setenv "DICTIONARY" "en_GB")
(setq ispell-program-name "aspell")
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_GB"))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; -----------------
;; sudo via tramp
;; -----------------
;
;; Open a file as sudoer with: C-x C-r <file> 
;; http://www.emacswiki.org/emacs/TrampMode

(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
	 ;; use a separate history list for "root" files.
	 (file-name-history find-file-root-history)
	 (name (or buffer-file-name default-directory))
	 (tramp (and (tramp-tramp-file-p name)
		     (tramp-dissect-file-name name)))
	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-localname tramp)
	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))

(global-set-key [(control x) (control r)] 'find-file-root)


(tool-bar-mode -1)


