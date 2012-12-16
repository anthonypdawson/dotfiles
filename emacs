(require 'cl)
(defvar emacs-config (expand-file-name "~/.emacs.d/") "emacs.d dir")
;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; create directory if necessary for .el files
(make-directory "~/.emacs.d/plugins/" t)

;; add base & plugins directory to load path
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))

;; For ruby-block.el

;; Add this line to your .emacs
;;
(require 'ruby-block)
(ruby-block-mode t)
;;
;; In addition, you can also add this line too.
;;
;; do overlay
;(setq ruby-block-highlight-toggle 'overlay)
;; display to minibuffer
;(setq ruby-block-highlight-toggle 'minibuffer)
;; display to minibuffer and do overlay
(setq ruby-block-highlight-toggle t)
;;
;; Default is minibuffer.

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/ac-dict")
(ac-config-default)


(load-file "/emacs/cedet-1.1/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu

(setq rsense-home "/home/ayd/src/emacs/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

;; path to ruby refm (reference manual)
(setq rsense-rurema-home "~/src/doc/rurema")
 ;; Complete by C-c .
    (add-hook 'ruby-mode-hook
              (lambda ()
                (local-set-key (kbd "C-x .") 'ac-complete-rsense)))
 ;; Complete by C-c .
    (add-hook 'ruby-mode-hook
              (lambda ()
                (local-set-key (kbd "C-x //") 'rsense-complete)))

;; Autocomplete
 (add-hook 'ruby-mode-hook
              (lambda ()
                (add-to-list 'ac-sources 'ac-source-rsense-method)
                (add-to-list 'ac-sources 'ac-source-rsense-constant)))

;; (message "%s" (shell-command-to-string (format "/home/ayd/src/emacs/rsense-0.3/bin/rsense type-inference --file=%s --location=%s" (buffer-file-name) (1- (point)))))
