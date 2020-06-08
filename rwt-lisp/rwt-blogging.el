
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
sake."
  (interactive "sDraft name: ")
  (let ((full-name (expand-file-name (concat name ".md")
				     (expand-file-name "_drafts"
						       rwt/blog-base))))
    (find-file full-name)
    (rwt/blog-yaml)))

(provide 'rwt-blogging)
