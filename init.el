(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("dcdd1471fde79899ae47152d090e3551b889edf4b46f00df36d653adc2bf550d" "68d8ceaedfb6bdd2909f34b8b51ceb96d7a43f25310a55c701811f427e9de3a3" default)))
 '(hl-sexp-background-color "#efebe9")
 '(package-selected-packages
   (quote
    (dracula-theme edit-indirect cider markdown-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; load my custom codez...
(add-to-list 'load-path "~/.emacs.d/rwt-lisp")
(require 'rwt-utils)
(require 'rwt-blogging)
(setq rwt/blog-base "J:/ghio_blog")

;; figure out a good font based on the ones installed... go for 11pt
;; font by default.
(let ((ffs (font-family-list)))
  (cond
   ((member "Cascadia Mono" ffs) (set-frame-font "Cascadia Mono"))
   ((member "Go Mono" ffs) (set-frame-font "Go Mono"))
   ((member "Source Code Pro" ffs) (set-frame-font "Source Code Pro"))
   ((member "Consolas" ffs) (set-frame-font "Consolas"))))
(set-face-attribute 'default nil :height 110)

;; I like auto-fill mode...
(add-hook 'markdown-mode-hook #'auto-fill-mode)

;; allow me to use disabled functions
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(setq inhibit-startup-screen t) ; turn off the start screen
(tool-bar-mode -1)              ; turn off the toolbar
(prefer-coding-system 'utf-8)   ; unicode, baby
(blink-cursor-mode 0)           ; don't blink the cursor

;; set global keys for functions i use a lot
(global-set-key (kbd "C-, d i") #'rwt/delete-around-point)
(global-set-key (kbd "C-, b d") #'rwt/blog-draft)
(global-set-key (kbd "C-, b o") #'rwt/blog-open)
