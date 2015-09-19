
;;------ Melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;------ autopair
;(require 'autopair)			
;(autopair-global-mode) ;; to enable in all buffers

;;------ window 
;;(set-foreground-color "grey")
;;(set-background-color "black")
;;(set-cursor-color "gold1")
;;(set-mouse-color "gold1")

(window-divider-mode t)

;;theme color
(load-theme 'atom-one-dark t)

;;------ operation
(show-paren-mode t);; match bracket

(setq default-directory "~/");; set defualt file path

(setq column-number-mode t);; show column number
(setq line-number-mode t);; show line number
(global-linum-mode t);; show line number in left side

(setq scroll-margin 3 scroll-conservatively 10000);; scroll 3 lines near edge

(setq visible-bell t);; close the wrong hint

;;------ key binds
;;(global-set-key (kbd "C-j") 'gotoline)
(global-set-key (kbd "C->") 'other-window)
(global-set-key (kbd "C-)") 'scroll-left) ; to right
(global-set-key (kbd "C-(") 'scroll-right) ; to left
(put 'scroll-left 'disabled nil)

;;------ auto-complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(ac-config-default)

;;------ smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ----- speedbar options
;;(setq sr-speedbar-right-side nil)
(defun sr-speedbar-toggle-select ()
  (interactive)
  (sr-speedbar-toggle)
  (if (sr-speedbar-exist-p)
      (sr-speedbar-select-window)))
(global-set-key (kbd "C-c <C-return>") 'sr-speedbar-toggle-select)
(setq speedbar-use-images nil)

;; ----- ace jump
(global-set-key (kbd "<escape> SPC") 'ace-jump-word-mode)
(global-set-key (kbd "<escape> l") 'ace-jump-line-mode)
(global-set-key (kbd "<escape> c") 'ace-jump-char-mode)

;; ----- title name
(setq frame-title-format "Salamander@%b")

;; ----- eliminate long 'yes' or 'no' prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; ----- which key 'guide-key'
(which-key-mode)

;; ----- indent guide
(indent-guide-global-mode)

(provide 'my-init)
