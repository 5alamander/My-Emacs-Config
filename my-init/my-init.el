;;; 设置中文字体--微软雅黑
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
		    charset
		    (font-spec :family "Microsoft YaHei" :size 15)))
;;------ Melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;------ window 
(window-divider-mode t)
;;theme color
(load-theme 'atom-one-dark t)
(global-hl-line-mode)			;highlight current line
(set-face-background 'hl-line "black")	;to distinguish current line and selected
(set-face-foreground 'highlight nil)

;;------ operation
(show-paren-mode t)		      ; match 'parentheses'
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
(add-hook 'cider-repl-mode-hook
	  (lambda () (paredit-mode) (rainbow-delimiters-mode)))
(add-hook 'eshell-mode-hook
	  (lambda () (paredit-mode)))

(setq default-directory "~/");; set defualt file path

(setq column-number-mode t);; show column number
(setq line-number-mode t);; show line number
(global-linum-mode t);; show 'line-number' in left side
(menu-bar-mode -1);; hide 'menu-bar'
(tabbar-mode t)
(tabbar-ruler-up t);; show 'tabbar'

(setq scroll-margin 3 scroll-conservatively 10000);; scroll 3 lines near edge

(setq visible-bell t);; close the wrong hint

;;------ key binds
;;; multiple cursor
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;; window
(global-set-key (kbd "C-S-i") 'windmove-up)
(global-set-key (kbd "C-S-k") 'windmove-down)
(global-set-key (kbd "C-S-j") 'windmove-left)
(global-set-key (kbd "C-S-l") 'windmove-right)
;;; buffer
(global-set-key (kbd "C-S-u") 'tabbar-backward)
(global-set-key (kbd "C-S-o") 'tabbar-forward)
;;; scroll
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
(require 'company)
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
(global-set-key (kbd "C-z t") 'neotree-toggle)

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
     )))
(global-set-key (kbd "C-c <C-return>") 'sr-speedbar-toggle-select)

(setq speedbar-use-images nil)		;show without images

;; ----- ace jump
(global-set-key (kbd "<escape> SPC") 'ace-jump-word-mode) ;may delete this

(require 'bookmark+)
(define-key key-translation-map (kbd "<escape> p") (kbd "C-x p"))
(define-key key-translation-map (kbd "<escape> j") (kbd "C-x j"))
(define-key key-translation-map (kbd "<escape> r") (kbd "C-x r"))

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
;;; yas-ido
(yas-global-mode 1)			; reset the yas tab
(define-key yas-minor-mode-map [(tab)]        nil)
(define-key yas-minor-mode-map (kbd "TAB")    nil)
(define-key yas-minor-mode-map (kbd "<tab>")  nil)
(defun yas-ido-expand ()
  "Lets you select (and expand) a yasnippet key"
  (interactive)
    (let ((original-point (point)))
      (while (and
              (not (= (point) (point-min) ))
              (not
               (string-match "[[:space:]\n]" (char-to-string (char-before)))))
        (backward-word 1))
    (let* ((init-word (point))
           (word (buffer-substring init-word original-point))
           (list (yas-active-keys)))
      (goto-char original-point)
      (let ((key (remove-if-not
                  (lambda (s) (string-match (concat "^" word) s)) list)))
        (if (= (length key) 1)
            (setq key (pop key))
          (setq key (ido-completing-read "key: " list nil nil word)))
        (delete-char (- init-word original-point))
        (insert key)
        (yas-expand)))))
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-ido-expand)
;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas)
	  (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

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

;;; ----- common hook
(defvar common-hook-modes '(coffee-mode js-mode csharp-mode))
(dolist (mode common-hook-modes)
  (add-hook (intern (concat (symbol-name mode) "-hook"))
	    (lambda ()
	      (rainbow-delimiters-mode)
	      (autopair-mode 1))))
;; ----- scheme
; (setq scheme-program-name "mit-scheme") 
; this did not work well in 'mit-scheme'

(provide 'my-init)
