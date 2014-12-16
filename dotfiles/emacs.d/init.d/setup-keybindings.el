(define-key global-map (kbd "M-g")   'goto-line)
(define-key global-map (kbd "C-h a") 'apropos)

(define-key global-map (kbd "M-n")
  (lambda (arg) (interactive "p") (scroll-up (* 3 arg))))
(define-key global-map (kbd "M-p")
  (lambda (arg) (interactive "p") (scroll-down (* 3 arg))))

(require 'setup-variables)
(define-key global-map (kbd "C-j") 'vi-open-line-below)
(define-key global-map (kbd "C-S-J") 'vi-open-line-above)

(provide 'setup-keybindings)
