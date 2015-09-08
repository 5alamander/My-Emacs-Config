(provide 'hydra-init)

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
   "
Move Point^^^^   Move Splitter   ^Ace^                       ^Split^
--------------------------------------------------------------------------------
_w_, _<up>_      Shift + Move    _C-a_: ace-window           _2_: split-window-below
_a_, _<left>_                    _C-s_: ace-window-swap      _3_: split-window-right
_s_, _<down>_                    _C-d_: ace-window-delete    ^ ^
_d_, _<right>_                   ^   ^                       ^ ^
You can use arrow-keys or WASD.
"
   ("2" split-window-below nil)
   ("3" split-window-right nil)
   ("a" windmove-left nil)
   ("s" windmove-down nil)
   ("w" windmove-up nil)
   ("d" windmove-right nil)
   ("A" hydra-move-splitter-left nil)
   ("S" hydra-move-splitter-down nil)
   ("W" hydra-move-splitter-up nil)
   ("D" hydra-move-splitter-right nil)
   ("<left>" windmove-left nil)
   ("<down>" windmove-down nil)
   ("<up>" windmove-up nil)
   ("<right>" windmove-right nil)
   ("<S-left>" hydra-move-splitter-left nil)
   ("<S-down>" hydra-move-splitter-down nil)
   ("<S-up>" hydra-move-splitter-up nil)
   ("<S-right>" hydra-move-splitter-right nil)
   ("C-a" ace-window nil)
   ("u" hydra--universal-argument nil)
   ("C-s" (lambda () (interactive) (ace-window 4)) nil)
   ("C-d" (lambda () (interactive) (ace-window 16)) nil)
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
      (if (looking-back "^")		; if it is the begining of the line
          (hydra-org-template/body)
        (self-insert-command 1)))))	; else self insert


;; -------------------------------------------------------
;; vi-move
(defhydra hydra-vi (:pre (set-cursor-color "#ffffff")
			 :post (progn
				 (set-cursor-color "#4f94cd")
				 (message "Thank you, come again.")))
  "vi"
  ("l" forward-char)
  ("j" backward-char)
  ("k" next-line)
  ("i" previous-line)
  ("q" nil "quit"))
(global-set-key (kbd "<f8>") 'hydra-vi/body)
