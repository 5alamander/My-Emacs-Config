(global-evil-leader-mode 1) 		; enable this before evil-modffe
(evil-mode 1)
(global-evil-surround-mode 1)
;;
(global-set-key [f8] 'evil-normal-state)

;;; evil-ace-jump
(define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
(define-key evil-motion-state-map (kbd "C-SPC") #'evil-ace-jump-word-mode)
(define-key evil-motion-state-map (kbd "M-SPC") #'evil-ace-jump-line-mode)

(define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
(define-key evil-operator-state-map (kbd "C-SPC") #'evil-ace-jump-word-mode)
(define-key evil-operator-state-map (kbd "M-SPC") #'evil-ace-jump-line-mode)

;; change mode-line color by evil state, it's cool
(lexical-let ((default-color (cons (face-background 'mode-line)
				   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
	    (lambda ()
	      (let ((color (cond ((minibufferp) default-color)
				 ((evil-insert-state-p) '("#9f702e" . "#ffffff"))
				 ((evil-emacs-state-p) '("#444488" . "#ffffff"))
				 ((buffer-modified-p) '("#006fa0" . "#ffffff"))
				 (t default-color))))
		(set-face-background 'mode-line (car color))
		(set-face-foreground 'mode-line (cdr color))))))

(evil-leader/set-key
 "f" 'find-file
 "b" 'ido-switch-buffer
 "B" 'ido-switch-buffer-other-window)

;;; set evil-leader for mode
;; (evil-leader/set-key-for-mode
;;  'emacs-lisp-mode
;;  "b" 'byte-compile-file)

;;; fix bug
;; (defun evil-execute-in-normal-state () 
;;   "Execute the next command in Normal state. C-o o works in insert-mode" 
;;   (interactive) 
;;   (evil-delay
;;       '(not (memq
;; 	     this-command 
;; 	     '(evil-execute-in-normal-state 
;; 	       evil-use-register 
;; 	       digit-argument 
;; 	       negative-argument 
;; 	       universal-argument 
;; 	       universal-argument-minus 
;; 	       universal-argument-more 
;; 	       universal-argument-other-key))) 
;;       `(progn 
;; 	 (if (evil-insert-state-p) 
;; 	     (let ((prev-state
;; 		    (cdr-safe (assoc 'normal evil-previous-state-alist)))) 
;; 	       (evil-change-state prev-state) 
;; 	       (setq evil-previous-state 'normal)) 
;; 	   (evil-change-to-previous-state)) 
;; 	 (setq evil-move-cursor-back ',evil-move-cursor-back)) 
;;     'post-command-hook) 
;;   (setq evil-move-cursor-back nil) 
;;   (evil-normal-state) 
;;   (evil-echo "Switched to Normal state for the next command ...")) 
