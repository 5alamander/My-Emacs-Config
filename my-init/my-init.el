
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
(global-hl-line-mode)			;highlight current line
(set-face-background 'hl-line "black")	;to distinguish current line and selected
(set-face-foreground 'highlight nil)

;;------ operation
(show-paren-mode t)		      ; match bracketed
(global-set-key
 (kbd "<f10>")
 (lambda ()
   (interactive)
   (if paredit-mode
       (disable-paredit-mode)
     (enable-paredit-mode))))
(add-hook 'emacs-lisp-mode-hook
	  (lambda () (paredit-mode) (rainbow-delimiters-mode)))
(add-hook 'clojure-mode-hook
	  (lambda () (paredit-mode) (rainbow-delimiters-mode)))

(setq default-directory "~/");; set defualt file path

(setq column-number-mode t);; show column number
(setq line-number-mode t);; show line number
(global-linum-mode t);; show line number in left side

(setq scroll-margin 3 scroll-conservatively 10000);; scroll 3 lines near edge

(setq visible-bell t);; close the wrong hint

;;------ key binds
(global-set-key (kbd "C->") 'other-window)   ; may delete
(global-set-key (kbd "C-S-i") 'windmove-up)
(global-set-key (kbd "C-S-k") 'windmove-down)
(global-set-key (kbd "C-S-j") 'windmove-left)
(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-u") 'previous-buffer)
(global-set-key (kbd "C-S-o") 'next-buffer)
(global-set-key (kbd "C-)") 'scroll-left)    ; may change this
(global-set-key (kbd "C-x >") 'scroll-left)  ; switch with right
(global-set-key (kbd "C-(") 'scroll-right)   ; may delete this
(global-set-key (kbd "C-x <") 'scroll-right) ;
(put 'scroll-left 'disabled nil)

(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-set-key (kbd "C-x g") 'google-this-mode-submap) ;google search

;; copy line
(global-set-key
 (kbd "M-w")
 (lambda ()
   (interactive)
   (if mark-active
       (kill-ring-save (region-beginning) (region-end))
     (progn
       (kill-ring-save (line-beginning-position) (line-end-position))
       (message "copy line")
       ))))
;; cut line
(global-set-key
 (kbd "C-w")
 (lambda ()
   (interactive)
   (if mark-active
       (kill-region (region-beginning) (region-end))
     (progn
       (kill-region (line-beginning-position) (line-end-position))
       (message "kill line")
       ))))

;; ;;------ auto-complete
;; (require 'auto-complete-config)
;; (ac-config-default)
;; ;; ------ yasnippet-color
;; (require 'yasnippet)			; this did not work
;; (defface ac-yasnippet-candidate-face
;;   '((t (:background "sandybrown" :foreground "black")))
;;   "Face for yasnippet candidate.")
;; (defface ac-yasnippet-selection-face
;;   '((t (:background "coral3" :foreground "white")))
;;   "Face for the yasnippet selected candidate.")
;; (defvar ac-source-yasnippet
;;   '((candidates . ac-yasnippet-candidates)
;;     (action . yas/expand)
;;     (candidate-face . ac-yasnippet-candidate-face)
;;     (selection-face . ac-yasnippet-selection-face))
;;   "Source for Yasnippet.")
;;; ------ company ------
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 2)
(setq company-idle-delay 0.3)

;;------ smex
(global-set-key (kbd "M-x") 'smex)
;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; ------ helm
(global-set-key (kbd "M-X") 'helm-M-x)
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z m") 'helm-M-x)
(global-set-key (kbd "C-z b") 'helm-buffers-list)
(global-set-key (kbd "C-z k") 'helm-show-kill-ring)
(global-set-key (kbd "C-z f") 'helm-find-files)
(global-set-key (kbd "C-z i") 'helm-imenu)
(global-set-key (kbd "C-z o") 'helm-occur)

;; ----- speedbar options
;;(setq sr-speedbar-right-side nil)

(defun sr-speedbar-toggle-select ()
  (interactive)
  (sr-speedbar-toggle)
  (if (sr-speedbar-exist-p)
      (progn
	(sr-speedbar-select-window)	;select after opened
	(with-current-buffer sr-speedbar-buffer-name
	  (setq window-size-fixed 'width)) ;to keep speed bar width
	(sr-speedbar-refresh)		   ;refresh after open
	)
    (progn
     (sr-speedbar-refresh)		;refresh after closed
     )
    ))
(global-set-key (kbd "C-c <C-return>") 'sr-speedbar-toggle-select)

(setq speedbar-use-images nil)		;show without images

;; ----- ace jump
(global-set-key (kbd "<escape> SPC") 'ace-jump-word-mode) ;may delete this
(global-set-key (kbd "M-g SPC") 'ace-jump-word-mode)
(global-set-key (kbd "M-g g") 'ace-jump-line-mode)
(global-set-key (kbd "M-g c") 'ace-jump-char-mode)

;; ----- title name
(setq frame-title-format "Salamander@%b")

;; ----- eliminate long 'yes' or 'no' prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; ----- which key 'guide-key'
(which-key-mode)
(which-key-setup-side-window-right-bottom)

;; ----- indent guide
(indent-guide-global-mode)

;; ----- ido
(ido-mode 1)

;; ----- Languages
(require 'speedbar)
(speedbar-add-supported-extension
 '(".coffee" ".clj" ".md"))

;; ----- CoffeeScript
(with-eval-after-load "coffee-mode"
  (custom-set-variables '(coffee-tab-width 2)))

;; ----- JavaScript
(with-eval-after-load "js"
  (setq js-indent-level 2))

;; ----- scheme
; (setq scheme-program-name "mit-scheme") 
; this did not work well in 'mit-scheme'

(provide 'my-init)
