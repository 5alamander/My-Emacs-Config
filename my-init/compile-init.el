(defun run-current-file ()		
  "Execute or compile the current file.
For example, if the current buffer is the file x.pl,
then it'll call 'perl x.pl' in a shell.
The file can be php, perl, python, ruby, javascript, bash, ocaml, vb, elsip.
File suffix is used to determine what program to run.

If the file is modified, ask if you want to save first.
(This command always run the saved version.)

If the file is emacs lisp, run the byte compiled version if exist."

  (interactive)
  (let (suffixMap fName fSuffix progName cmdStr)
    ;; a keyed list of file suffix to command-line program path/name
    (setq suffixMap
	  '(("php" . "php")
	    ("coffee" . "coffee")
	    ("pl" . "perl")
	    ("py" . "python")
	    ("rb" . "ruby")
	    ("js" . "node")
	    ("sh" . "bash")
	    ("ml" . "ocaml")
	    ("vbs" . "cscript")))
    (setq fName (buffer-file-name))
    (setq fSuffix (file-name-extension fName))
    (setq progName (cdr (assoc fSuffix suffixMap)))
    (setq cmdStr (concat progName " \"" fName "\""))

    (when (buffer-modified-p)
      (progn
	(when (y-or-n-p "Buffer modified. Do you want to save first?")
	  (save-buffer))))
    (if (string-equal fSuffix "el")
	(progn
	  (load (file-name-sans-extension fName)))
      (if progName
	  (progn
	    (message "Running %s ..." fName)
	    (shell-command cmdStr "*run-current-file output*")
;            (pop-to-buffer "*run-current-file output*")
            )
	(message "No recognized program file suffix for this file.")))))

;; eval and replace
(defun eval-and-replace ()
  "Replace the preceding sexp with it's value"
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
	     (current-buffer))
    (error (message "Invalid expression")
	   (insert (current-kill 0)))))

(defun es-search*sa1 (input)
  "this method need `everything' installed, and add `es' to the path"
  (interactive "sSearch:")
  (shell-command (concat "es " input)
		 "*es search result*")
  (pop-to-buffer "*es search result*"))

;;; buffer copy name or directory
(defun copy-buffer-name*sa1 (choice)
  "Copy the buffer-file-name to the kill-ring"
  (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name")
  (let ((new-kill-string)
	(name (if (eq major-mode 'dired-mode)
		  (dired-get-filename)
		(or (buffer-file-name) ""))))
    (cond ((eq choice ?f)
	   (setq new-kill-string name))
	  ((eq choice ?d)
	   (setq new-kill-string (file-name-directory name)))
	  ((eq choice ?n)
	   (setq new-kill-string (file-name-nondirectory name)))
	  (t (message "Quit")))
    (when new-kill-string
      (message "%s copied" new-kill-string)
      (kill-new new-kill-string))))

;;; open windows explorer
(defun open-buffer-path*sa1 (choice)
  "Run explorer on the directory of this buffer."
  (interactive "cOpen directory (I) in, (O) out")
  (let* ((name (if (eq major-mode 'dired-mode)
		  (dired-get-filename)
		(or (buffer-file-name) "")))
	(file-name (replace-regexp-in-string
		    "/" "\\" name t t))
	(directory (replace-regexp-in-string
		    "/" "\\" (file-name-directory name) t t)))
    (shell-command
     (concat "explorer /select,"
	     (cond ((eq choice ?i) file-name)
		   ((eq choice ?o) directory))))))

(global-set-key [M-f12] 'open-buffer-path*sa1)
