
(message "load hydra init")
;; ----------------------------------------
;; hydra window function
(defun hydra-move-splitter-left (arg)
  "move window splitter left."
  (interactive "p")
  (if (let ((window-wrap-around))
	(windmove-find-other-window 'right))
      (shrink-window-horizontally arg)
    (enlarge-window-horizontally arg)))
(defun hydra-move-splitter-right (arg)
  "Move window splitter right."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (enlarge-window-horizontally arg)
    (shrink-window-horizontally arg)))
(defun hydra-move-splitter-up (arg)
  "Move window splitter up."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (enlarge-window arg)
    (shrink-window arg)))
(defun hydra-move-splitter-down (arg)
  "Move window splitter down."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (shrink-window arg)
    (enlarge-window arg)))

;; ----------------------------------------
;; set keys
(global-set-key
 (kbd "<f9>")
 (defhydra hydra-window (:color amaranth)
   "hydra-window" 
   ("1" delete-other-windows nil)
   ("2" split-window-below nil)
   ("3" split-window-right nil)
   ("0" delete-window nil)
   ("j" windmove-left nil)
   ("k" windmove-down nil)
   ("i" windmove-up nil)
   ("l" windmove-right nil)
   ("<left>" windmove-left nil)
   ("<down>" windmove-down nil)
   ("<up>" windmove-up nil)
   ("<right>" windmove-right nil)
   ("<S-left>" hydra-move-splitter-left nil)
   ("<S-down>" hydra-move-splitter-down nil)
   ("<S-up>" hydra-move-splitter-up nil)
   ("<S-right>" hydra-move-splitter-right nil)
;   ("C-a" ace-window nil)
   ("u" hydra--universal-argument nil)
;   ("C-s" (lambda () (interactive) (ace-window 4)) nil)
;   ("C-d" (lambda () (interactive) (ace-window 16)) nil)
;   ("a 1" split-window-right)
;   ("a 2" split-window-below)
   ("SPC" nil "quit")))

;; -------------------------------------------------------
;; org-template
(defhydra hydra-org-template (:color blue :hint nil)
  "
_c_enter  _q_uote     _e_macs-lisp    _L_aTeX:
_l_atex   _E_xample   _p_erl          _i_ndex:
_a_scii   _v_erse     _P_erl tangled  _I_NCLUDE:
_s_rc     _C_lojure   plant_u_ml      _H_TML:
_h_tml    ^ ^         ^ ^             _A_SCII:
"
  ("s" (hot-expand "<s"))
  ("E" (hot-expand "<e"))
  ("q" (hot-expand "<q"))
  ("v" (hot-expand "<v"))
  ("c" (hot-expand "<c"))
  ("l" (hot-expand "<l"))
  ("h" (hot-expand "<h"))
  ("a" (hot-expand "<a"))
  ("L" (hot-expand "<L"))
  ("i" (hot-expand "<i"))
  ("e" (progn
	 (hot-expand "<s")
	 (insert "emacs-lisp")
	 (forward-line)))
  ("p" (progn
	 (hot-expand "<s")
	 (insert "perl")
	 (forward-line)))
  ("u" (progn
	 (hot-expand "<s")
	 (insert "plantuml :file CHANGE.png")
	 (forward-line)))
  ("C" (progn
	 (hot-expand "<s")
	 (insert "clojure")
	 (forward-line)))
  ("P" (progn
	 (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
	 (hot-expand "<s")
	 (insert "perl")
	 (forward-line)))
  ("I" (hot-expand "<I"))
  ("H" (hot-expand "<H"))
  ("A" (hot-expand "<A"))
  ("<" (insert "<<"))			;self-insert-command "ins")
  ("SPC" nil "quit"))

(defun hot-expand (str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))

(with-eval-after-load "org"
  (define-key org-mode-map "<"
    (lambda () (interactive)
      (if (and
	   (looking-back "<")
	   (not (looking-back "<<")));(looking-back "^")
          (progn
	    (delete-backward-char 1)
	    (hydra-org-template/body))	    
        (self-insert-command 1)))))	; else self insert

;; -------------------------------------------------------
(defun hydra-beginning-of-sexp ()
  (interactive)
  (thing-at-point--beginning-of-sexp))
(defun hydra-end-of-sexp ()
  (interactive)
  (thing-at-point--end-of-sexp))

;; -------------------------------------------------------
;; vi-move.
(defhydra hydra-vi (:pre (set-cursor-color "#ffffff")
			 :post (progn
				 (set-cursor-color "#4f94cd")
				 (message "Thank you, come again.")))
  "vi-<hi>-move"
  ;; move
  ("l" forward-char "forward")
  ("j" backward-char "backward")
  ("k" next-line "down")
  ("i" previous-line "up")
  ("a" beginning-of-line nil)
  ("e" end-of-line nil)
  
  ;; move in word
  ("M-l" forward-word nil)		;<M-f>
  ("M-j" backward-word nil)		;<M-b>
  ("M-i" backward-paragraph nil)	;<M-{>
  ("M-k" forward-paragraph nil)		;<M-}>
  ("M-e" forward-sentence nil)		;<M-e>
  ("M-a" backward-sentence nil)		;<M-a>
  
  ;; move in sexp
  ("L" forward-sexp nil)		;<C-M-f>
  ("J" backward-sexp nil)		;<C-M-b>
  ("K" down-list nil)			;<C-M-d>
  ("I" backward-up-list nil)		;<C-M-u>
  ("A" hydra-beginning-of-sexp nil)
  ("E" hydra-end-of-sexp nil)
  
  ("SPC" nil "quit"))
(global-set-key (kbd "<f8>") 'hydra-vi/body)

;; -------------------------------------------------------
;; em-move.
(defhydra hydra-em-move (:pre (set-cursor-color "#ffffff")
				   :post (progn
					   (set-cursor-color "#4f94cd")
					   (message "exit hydra-em-move-char")))
  "em-move-char"
  ("f" forward-char "forward")		;<C-f>
  ("b" backward-char "backward")	;<C-b>
  ("n" next-line "down")		;<C-n>
  ("p" previous-line "up")		;<C-p>
  ("a" beginning-of-line)		;<C-a>
  ("e" end-of-line)			;<C-e>

  ("M-f" forward-word)			;<M-f>
  ("M-b" backward-word)			;<M-b>
  ("M-p" backward-paragraph)		;<M-{>, <M-p> is undefined
  ("M-n" forward-paragraph)		;<M-}>, <M-n> is undefined
  ("M-e" forward-sentence)		;<M-e>
  ("M-a" backward-sentence)		;<M-a>

  ("F" forward-sexp)		;<C-M-f>
  ("B" backward-sexp)		;<C-M-b>
  ("D" down-list)		;<C-M-d>,
  ("U" backward-up-list)	;<C-M-u>, 
  ("N" forward-list)		;<C-M-n> is forward-list 
  ("P" backward-list)		;<C-M-p> is backward-list
  ("A" hydra-beginning-of-sexp) ;new defined, <C-M-a> is beginning-of-defun
  ("E" hydra-end-of-sexp )	;new defined, <C-M-e> is end-of-defun
  
  ("SPC" nil "quit"))
(global-set-key (kbd "<f7>") 'hydra-em-move/body)

(defhydra hydra-em-move-word (:pre (set-cursor-color "#ffffff")
				   :post (progn
					   (set-cursor-color "#4f94cd")
					   (message "exit hydra-em-move-word")))
  "em-move-word"
  ("f" forward-word)			;<M-f>
  ("b" backward-word)			;<M-b>
  ("p" backward-paragraph)		;<M-{>, <M-p> is undefined
  ("n" forward-paragraph)		;<M-}>, <M-n> is undefined
  ("e" forward-sentence)		;<M-e>
  ("a" backward-sentence)		;<M-a>
  
  ("SPC" nil "quit"))

(defhydra hydra-em-move-sexp (:pre (set-cursor-color "#ffffff")
				   :post (progn
					   (set-cursor-color "#4f94cd")
					   (message "exit hydra-em-move-word")))
  "em-move-sexp"
  ("f" forward-sexp "f-sexp")		;<C-M-f>
  ("b" backward-sexp "b-sexp")		;<C-M-b>
  ("d" down-list "d-list")		;<C-M-d>
  ("u" backward-up-list "u-list")	;<C-M-u>
  ("a" hydra-beginning-of-sexp "a-sexp") ;new defined
  ("e" hydra-end-of-sexp "e-sexp")	 ;new defined
  
  ("SPC" nil "quit"))

;;; search


(provide 'hydra-init)
