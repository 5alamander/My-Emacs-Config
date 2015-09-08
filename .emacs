
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("91faf348ce7c8aa9ec8e2b3885394263da98ace3defb23f07e0ba0a76d427d46" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (hydra ace-jump-mode sr-speedbar smex org atom-one-dark-theme atom-dark-theme autopair auto-overlays)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(window-divider-default-places t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))

;;------ org-mode GTD state
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "HANGUP" "|" "DONE" "CANCEL" "TEMP")))

;;------ language
;;(set-language-environment 'Chinese-GB)
;;(set-keyboard-coding-system 'utf-8)
;;(set-clipboard-coding-system 'utf-8)
;;(set-terminal-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'utf-8)
;;(set-default-coding-systems 'utf-8)
;;(set-selection-coding-system 'utf-8)
;;(modify-coding-system-alist 'process "*" 'utf-8)
;;(setq default-process-coding-system '(utf-8 . utf-8))
;;(setq-default pathname-coding-system 'utf-8)
;;(set-file-name-coding-system 'utf-8)
;;(setq ansi-color-for-comint-mode t)
;; don't work with shell-mode

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
(global-set-key (kbd "C-c <C-return>") 'sr-speedbar-toggle)
(setq speedbar-use-images nil)

;; ----- ace jump
(global-set-key (kbd "<escape> SPC") 'ace-jump-word-mode)
(global-set-key (kbd "<escape> l") 'ace-jump-line-mode)
(global-set-key (kbd "<escape> c") 'ace-jump-char-mode)

;; ----- title name
(setq frame-title-format "emacs@%b")

;; ----- eliminate long 'yes' or 'no' prompts
(fset 'yes-or-no-p 'y-or-n-p)


;; ----- auto load .el in "~/my-init"
(mapc 'load (directory-files "~/my-init" t "\\.el$"))
