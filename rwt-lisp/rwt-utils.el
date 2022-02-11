;;   -*- lexical-binding: t; -*-
;; ----------------------------------------------------------------------
;; Just a place for random utilities
;; ----------------------------------------------------------------------

;; ----------------------------------------------------------------------
;; delete-around-point gives a vim command like di"/ca(/etc.
;; ----------------------------------------------------------------------
(defun rwt/search-delimiters (dir delim other)
  "Search for `delim` either forward or backward based on `dir`,
   up to the end of the line. Every time you find `other`, search
   for additional `delim`.  This method handles nested delimiters
   as long as they are balanced.

   Note: this won't find the delimiter in the first or last character
   of the file. I consider that limitation acceptable."
  (let ((start-pt (point))
	(limit    (if (> dir 0)
		      (min (point-max) (1+ (line-end-position)))
		    (max (point-min) (1- (line-beginning-position)))))
	(count    1))
    (while (and (> count 0) (/= (point) limit))
      (let ((curch (char-after)))
	(cond ((char-equal curch delim) (setq count (1- count)))
	      ((char-equal curch other) (setq count (1+ count))))
	(forward-char dir)))
    (if (= count 0)
	(progn (when (< dir 0) (forward-char 1))
	       t)
      (goto-char start-pt)
      nil)))

(defun rwt/delete-around-point (arg delim)
  "Kills the region around the point, marked by delimiters,
   which may be any character.  If the character is a bracket,
   then matching brackets are assumed.  With C-u modifier, also
   erases the brackets."
  (interactive "*P\ncDelimiter: ")
  (let* ((other (or (cdr (assoc delim
				'((?\{ . ?\}) (?\< . ?\>)
				  (?\( . ?\)) (?\[ . ?\]))
				#'char-equal))
		    delim)))
    (when (rwt/search-delimiters -1 delim other)
      (let ((start-pt (+ (point) (if arg 0 1))))
	(forward-char 1)
	(when (rwt/search-delimiters 1 other delim)
	  (delete-region start-pt (- (point) (if arg 0 1)))
	  (goto-char start-pt))))))

(defun rwt/page-menu ()
  "Runs occur on the page-delimiter, to give a menu of pages."
  (interactive)
  (occur page-delimiter))


(defun rwt/total-time (shifts)
  "Given `shifts` as a list of '( ((hh . mm) (hh . mm)) ... ) shifts, add up
all the fractional hours"
  (let ((hhmm-to-hours (lambda (tspec) (+ (car tspec) (/ (cdr tspec) 60.0)))))
    (apply #'+
	   (mapcar #'(lambda (shift)
		       (apply #'- (reverse (mapcar hhmm-to-hours shift))))
		   shifts))))

(provide 'rwt-utils)
