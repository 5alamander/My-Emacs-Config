
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
 '(autopair-blink nil)
 '(bmkp-last-as-first-bookmark-file "d:\\Emacs\\Config\\.emacs.d\\bookmarks")
 '(case-fold-search nil)
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(company-idle-delay 0.3)
 '(company-show-numbers t)
 '(custom-safe-themes
   (quote
    ("3ed645b3c08080a43a2a15e5768b893c27f6a02ca3282576e3bc09f3d9fa3aaa" "91faf348ce7c8aa9ec8e2b3885394263da98ace3defb23f07e0ba0a76d427d46" default)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(linum-delay t)
 '(linum-format (quote dynamic))
 '(neo-theme (quote ascii))
 '(package-selected-packages
   (quote
    (markdown-mode+ markdown-mode csharp-mode bookmark+ tabbar-ruler tabbar multiple-cursors neotree company rainbow-delimiters helm yasnippet paredit cider highlight-parentheses google-this coffee-mode indent-guide popup which-key guide-key hydra ace-jump-mode sr-speedbar smex org atom-one-dark-theme atom-dark-theme autopair auto-overlays)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tabbar-background-color nil)
 '(tabbar-mode t nil (tabbar))
 '(tabbar-use-images nil)
 '(tool-bar-mode nil)
 '(window-divider-default-places t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 120 :width normal))))
 '(company-preview ((t (:background "medium slate blue" :foreground "black"))))
 '(company-preview-common ((t (:inherit company-preview :foreground "yellow"))))
 '(company-preview-search ((t (:inherit company-preview :background "lime green"))))
 '(company-scrollbar-bg ((t (:inherit company-tooltip :background "SystemHotTrackingColor"))))
 '(company-scrollbar-fg ((t (:background "SystemButtonText"))))
 '(company-template-field ((t (:background "gray17" :foreground "black"))))
 '(company-tooltip ((t (:background "gray10" :foreground "ghost white"))))
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "slate gray"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :foreground "gainsboro"))))
 '(company-tooltip-common-selection ((t (:background "SystemMenuHilight" :foreground "SystemButtonText"))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "steel blue"))))
 '(helm-candidate-number ((t (:background "slate blue" :foreground "black"))))
 '(helm-selection ((t (:background "SystemMenuText"))))
 '(helm-source-header ((t (:background "dark slate blue" :foreground "white" :weight bold :height 1.3 :family "Sans Serif"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "green yellow"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "orange red"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "magenta"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "deep sky blue"))))
 '(show-paren-match ((t (:background "sea green"))))
 '(show-paren-mismatch ((t (:background "red" :foreground "white"))))
 '(tabbar-unselected ((t (:inherit nil :stipple nil :background "steel blue" :foreground "#282C34" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Consolas"))))
 '(tabbar-unselected-modified ((t (:inherit tabbar-unselected :foreground "dark red" :weight bold))))
 '(window-divider ((t (:foreground "gray10"))))
 '(window-divider-first-pixel ((t (:foreground "gray10"))))
 '(window-divider-last-pixel ((t (:foreground "gray10")))))

;;------ org-mode GTD state
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "HANGUP" "|" "DONE" "CANCEL" "TEMP")))

;;; ������������--΢���ź�
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
		    charset
		    (font-spec :family "Microsoft YaHei" :size 15)))
(setq default-buffer-file-coding-system 'utf-8-emacs)

;;; backup
(setq backup-directory-alist '(("." . "~/.backup")))
(setq backup-by-copying t)

;; ----- auto load .el in "~/my-init"
(mapc 'load (directory-files "~/my-init" t "\\.el$"))
 
