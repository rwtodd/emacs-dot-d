;;   -*- lexical-binding: t; -*-

;; ----------------------------------------------------------------------
;; blogging helper functions
;; ----------------------------------------------------------------------

(defun rwt/blog-yaml ()
  "Adds a blank YAML block suitable for a jekyll blog post to the
top of the current file."
  (interactive)
  (goto-char (point-min))
  (insert "---
layout: post
title: \"\"
categories: []
tags: []
---
")
  (end-of-line -3)
  (left-char))

(add-hook 'markdown-mode-hook
	  (lambda () (local-set-key (kbd "C-c y") #'rwt/blog-yaml)))

(defun rwt/blog-draft (name)
  "Generates a new file, `name`.md in the _drafts folder of the
blog at `rwt/blog-base`. It adds a blank YAML block for jekyll's
sake, and sets the fill-column to 77"
  (interactive "sDraft name: ")
  (let ((full-name (expand-file-name (concat name ".md")
				     (expand-file-name "_drafts"
						       rwt/blog-base))))
    (find-file full-name)
    (setq-local fill-column 77)
    (add-file-local-variable 'fill-column fill-column)
    (rwt/blog-yaml)))

(defun rwt/blog-open (fn)
  "Offer to open an existing blog post, defaulting to entries in
   the drafts directory.  With a prefix argument, default to posts
   made in the current year."
  (interactive
   (list
    (read-file-name
     "Blog entry: "
     (if current-prefix-arg
	 (file-name-as-directory (expand-file-name (format-time-string "%Y")
						   (expand-file-name "_posts" rwt/blog-base)))
       (file-name-as-directory (expand-file-name "_drafts" rwt/blog-base)))
     nil
     t)))
  (find-file fn))

(provide 'rwt-blogging)
