(define-key global-map (kbd "M-g")   'goto-line)
(define-key global-map (kbd "C-h a") 'apropos)

(define-key global-map (kbd "M-n")
  (lambda (arg) (interactive "p") (scroll-up (* 3 arg))))
(define-key global-map (kbd "M-p")
  (lambda (arg) (interactive "p") (scroll-down (* 3 arg))))

(require 'setup-variables)
(define-key global-map (kbd "C-j") 'vi-open-line-below)
(define-key global-map (kbd "C-S-J") 'vi-open-line-above)

;; -----------------------------------------------------------------------------
;; open, OPEN new lines
;; -----------------------------------------------------------------------------
;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one. 
 See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key (kbd "C-o") 'open-next-line)
(global-set-key (kbd "M-o") 'open-previous-line)

;; -----------------------------------------------------------------------------
(provide 'setup-keybindings)
