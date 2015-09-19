
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
   ("q" nil "quit")))


;; -------------------------------------------------------
;; org-template
(defhydra hydra-org-template (:color blue :hint nil)
  "
_c_enter  _q_uote     _e_macs-lisp    _L_aTeX:
_l_atex   _E_xample   _p_erl          _i_ndex:
_a_scii   _v_erse     _P_erl tangled  _I_NCLUDE:
_s_rc     ^ ^         plant_u_ml      _H_TML:
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
  ("P" (progn
	 (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
	 (hot-expand "<s")
	 (insert "perl")
	 (forward-line)))
  ("I" (hot-expand "<I"))
  ("H" (hot-expand "<H"))
  ("A" (hot-expand "<A"))
  ("<" self-insert-command "ins")
  ("o" nil "quit"))

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
;; vi-move.
(defhydra hydra-vi (:pre (set-cursor-color "#ffffff")
			 :post (progn
				 (set-cursor-color "#4f94cd")
				 (message "Thank you, come again.")))
  "vi"
  ;; move
  ("l" forward-char "forward")
  ("j" backward-char "backward")
  ("k" next-line "down")
  ("i" previous-line "up")
  ("a" beginning-of-line nil)
  ("e" end-of-line nil)
  
  ;; move in word
  ("L" forward-word nil)
  ("J" backward-word nil)
  ("K" forward-sentence nil)
  ("I" backward-sentence nil)
  ("p" backward-paragraph nil)
  ("n" forward-paragraph nil)	
  
  ;; move in sexp
  ("M-l" forward-sexp nil)
  ("M-j" backward-sexp nil)
  ("M-k" down-list nil)
  ("M-i" backward-up-list nil)
  
  ("SPC" nil "quit"))
(global-set-key (kbd "<f8>") 'hydra-vi/body)

;; move, 'ijkl'.
;; move word, M 'jl'. 
;; paragraph move [, ], --- M-{, M-} ,
;; sexp f, b, up, down

;; -------------------------------------------------------
(defhydra hydra-em-move (:pre (set-cursor-color "#ffffff")
			 :post (progn
				 (set-cursor-color "#4f94cd")
				 (message "Thank you, come again.")))
  "emacs move"
  ;; move
  ("f" forward-char "forward")
  ("b" backward-char "backward")
  ("n" next-line "down")
  ("p" previous-line "up")
  ("a" beginning-of-line nil)
  ("e" end-of-line nil)
  
  ;; move in word
  ("L" forward-word nil)
  ("J" backward-word nil)
  ("K" forward-sentence nil)
  ("I" backward-sentence nil)
  ("p" backward-paragraph nil)
  ("n" forward-paragraph nil)	
  
  ;; move in sexp
  ("M-l" forward-sexp nil)
  ("M-j" backward-sexp nil)
  ("M-k" down-list nil)
  ("M-i" backward-up-list nil)
  
  ("SPC" nil "quit"))

(provide 'hydra-init)
