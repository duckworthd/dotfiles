;; Extra key bindings
;; ------------------
;;
(define-key global-map [(control ?z)] nil)                    ; Appropriate C-z for a personal prefix key
(define-key global-map [(control ?z) ?a] 'align-current)      ; Note: try space before first entry then C-u C-z a
(define-key global-map [(control ?z) ?l] 'sort-lines)
(define-key global-map [(control ?z) ?t] 'delete-trailing-whitespace)
(define-key global-map [(control ?z) tab] 'bury-buffer)
(define-key global-map [(control tab)] 'bury-buffer)
(define-key global-map [(meta ?g)] 'goto-line)                ; Use XEmacs' M-g for goto-line in GNU too
(define-key global-map [(control ?h) ?a] 'apropos)            ; Apropos *all* symbols, not just commands
(define-key global-map [(control ?x) (control ?b)] 'ibuffer)  ; Why use buffer-menu when there's IBuffer?

(provide 'setup-keybindings)
