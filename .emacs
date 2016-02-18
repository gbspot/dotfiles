(custom-set-variables
 '(inhibit-startup-screen t))

(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; For homebrew packages on OSX
(add-to-list 'exec-path "/usr/local/bin")

;; start emacs server
(server-start)

;; Stop accidental minimization, since it can't be
;; reversed from the keyboard  (from EmacsWiki)
;; "Protect From Judd Mode"
(when window-system
    (global-unset-key [?\C-x ?\C-z])) ; iconify-or-deiconify-frame (C-x C-z)

;; ----------
;; editing
;; ----------

;; Default to text-mode (not fundamental mode)
(setq default-major-mode 'text-mode)

;; No tabs, spaces only
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq c-basic-offset 2)
(setq sh-basic-offset 2)
(setq sh-indentation 2)
(setq zsh-indentation 2)

(tool-bar-mode -1)
(global-font-lock-mode 1)
(setq inhibit-splash-screen t)
(setq font-lock-maximum-decoration 3)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(transient-mark-mode t)
(setq case-fold-search t)
(blink-cursor-mode 0)

(require 'ido)
(require 'uniquify)

(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)

;; Tweak uniquify layout
;; https://curiousprogrammer.wordpress.com/2009/07/13/my-emacs-defaults/
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; Drop all trailing whitespace on save
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Whitespace handling
(require 'whitespace)
;; scream after 80chars
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode +1)
; make carriage returns blue and tabs green
(custom-set-faces
 '(my-carriage-return-face ((((class color)) (:background "blue"))) t)
 '(my-tab-face ((((class color)) (:background "green"))) t)
 )
; add custom font locks to all buffers and all files
(add-hook
 'font-lock-mode-hook
 (function
  (lambda ()
    (setq
     font-lock-keywords
     (append
      font-lock-keywords
      '(
        ("\r" (0 'my-carriage-return-face t))
        ("\t" (0 'my-tab-face t))
        ))))))
; transform literal tabs into a right-pointing triangle
(setq
 whitespace-display-mappings ;http://ergoemacs.org/emacs/whitespace-mode.html
 '(
   (tab-mark 9 [9654 9] [92 9])
   ;others substitutions...
   ))


(global-linum-mode 1)
(column-number-mode 1)

;; store all backup and autosave files in the tmp dir
;; no more pesky ~#files# everywhere
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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

;; This seems to interfere with auto-complete
;; (add-to-list 'load-path "~/.emacs.d/auto-complete-clang")
;; (require 'auto-complete-clang)

;; (setq ac-auto-start nil)
;; (setq ac-quick-help-delay 0.5)

(setq x-alt-keysm 'meta)

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
(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized")
(require 'color-theme-solarized)
(color-theme-initialize)
;(color-theme-midnight)
(color-theme-solarized-dark)

;; --------
;; magit
;; --------
;; Require emacs >=24.4
;; Require git >= 1.9.4
(setq git-version
  (substring
    (shell-command-to-string "git --version | awk '{print $3}' | sed 's/\.[0-9]$//' | sed 's/\.rc.*$//'")
    0 -1))

(if (version< git-version "1.9")
    (progn (message "git is too old for magit support, need > 1.9"))
  (if (version< emacs-version "24.4")
      (progn (message "emacs is too old for magit, need >= 24.4"))

  (global-set-key (kbd "C-x g") 'magit-status)
  (add-to-list 'load-path "~/.emacs.d/dash.el")
  (add-to-list 'load-path "~/.emacs.d/magit/lisp")
  (require 'magit)
  (with-eval-after-load 'info
    (info-initialize)
    (add-to-list 'Info-directory-list
                 "~/.emacs.d/magit/Documentation/"))
  ))

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

;; ---------------------------
;; js2-mode (JavaScript-IDE)
;; ---------------------------
(add-to-list 'load-path "~/.emacs.d/js2-mode")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-basic-offset 2)
(setq js2-use-font-lock-faces t)

;; -----------
;; jade-mode
;; -----------
(add-to-list 'load-path "~/.emacs.d/jade-mode")
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl\\'" . sws-mode))

;; -----------
;; jam-mode
;; -----------
(require 'jam-mode)
(add-to-list 'auto-mode-alist '("\\.jam$" . jam-mode))
(add-to-list 'auto-mode-alist '("Jam\\.*" . jam-mode))

;; ---------------
;; dockerfile-mode
;; ---------------

(add-to-list 'load-path "~/.emacs.d/dockerfile-mode/")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; --------------------------
;; jedi (Python completion)
;; --------------------------
;;
;; Run M-x jedi:install-server RET to configure on first use
;; (requires 'pip install virtualenv')
;;
;; (add-to-list 'load-path "~/.emacs.d/emacs-epc")
;; (add-to-list 'load-path "~/.emacs.d/emacs-deferred")
;; (add-to-list 'load-path "~/.emacs.d/emacs-ctable")
;; (add-to-list 'load-path "~/.emacs.d/emacs-python-environment")
;; (require 'python-environment)

;; (require 'epc)
;; (setq jedi:server-command '("~/.emacs.d/emacs-jedi/jediepcserver.py"))
;; (add-to-list 'load-path "~/.emacs.d/emacs-jedi")
;; (require 'jedi)
;; (autoload 'jedi:setup "jedi" nil t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

;; for local site configs
(load "~/.emacs.local")
