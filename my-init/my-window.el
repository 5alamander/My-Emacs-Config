;;; ----- window
(defun windmove-find-and-run (dir arg window functor)
  "get and confirm the window at direction is interactive,
then run input `lambda' (functor window other-window)"
  (let ((other-window (windmove-find-other-window dir arg window)))
    (cond ((null other-window)
	   (error "No window %s from selected window" dir))
	  ((and (window-minibuffer-p other-window)
		(not (minibuffer-window-active-p other-window)))
	   (error "Minibuffer is inactive"))
	  (t (funcall functor window other-window)))))

(defun windmove-do-push-window (dir &optional arg window)
  "move the buffer to the window at direction DIR.
DIR, ARG, and WINDOW are handled as by `windmove-other-window-loc'.
If no window is at direction DIR, an error is signaled."
  (windmove-find-and-run
   dir arg window
   (lambda (window other-window)
     (set-window-buffer other-window (window-buffer window))
     (switch-to-prev-buffer))))

(defun windmove-do-grab-window (dir &optional arg window)
  "grab the buffer from the window at direction DIR."
  (windmove-find-and-run
   dir arg window
   (lambda (window other-window)
     (set-window-buffer window (window-buffer other-window))
     (switch-to-prev-buffer other-window))))

(defun windmove-do-swap-window (dir &optional arg window)
  (windmove-find-and-run
   dir arg window
   (lambda (window other-window)
     (let ((tbuffer (window-buffer window)))
       (set-window-buffer window (window-buffer other-window))
       (set-window-buffer other-window tbuffer)))))

;; (defun my-swap-buffer-up (&optional arg)
;;   (interactive "P")
;;    (windmove-do-push-window 'up arg))

;;; 
;;; ----- hydra
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

(global-set-key
 (kbd "<f9>")
 (defhydra hydra-window (:color amaranth)
   "hydra-window" 
   ("1" delete-other-windows nil)
   ("2" split-window-below nil)
   ("3" split-window-right nil)
   ("0" delete-window nil)
   ("C-j" (windmove-do-push-window 'left) nil)
   ("C-k" (windmove-do-push-window 'down) nil)
   ("C-i" (windmove-do-push-window 'up) nil)
   ("C-l" (windmove-do-push-window 'right) nil)
   ("M-j" (windmove-do-grab-window 'left) nil)
   ("M-k" (windmove-do-grab-window 'down) nil)
   ("M-i" (windmove-do-grab-window 'up) nil)
   ("M-l" (windmove-do-grab-window 'right) nil)
   ("C-M-j" (windmove-do-swap-window 'left) nil)
   ("C-M-k" (windmove-do-swap-window 'down) nil)
   ("C-M-i" (windmove-do-swap-window 'up) nil)
   ("C-M-l" (windmove-do-swap-window 'right) nil)
   ("j" windmove-left nil)
   ("k" windmove-down nil)
   ("i" windmove-up nil)
   ("l" windmove-right nil)
   ;; ("<left>" windmove-left nil)
   ("<S-left>" hydra-move-splitter-left nil)
   ("<S-down>" hydra-move-splitter-down nil)
   ("<S-up>" hydra-move-splitter-up nil)
   ("<S-right>" hydra-move-splitter-right nil)
;   ("C-a" ace-window nil)
   ("u" hydra--universal-argument nil)
;   ("C-s" (lambda () (interactive) (ace-window 4)) nil)
;   ("C-d" (lambda () (interactive) (ace-window 16)) nil)
   ("SPC" nil "quit")))

;;; ----- winner mode
(winner-mode 1)
(global-set-key (kbd "<escape> u") 'winner-undo)
(global-set-key (kbd "<escape> U") 'winner-redo)

(provide 'my-window)
