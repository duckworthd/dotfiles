;; Interactively do things
;; -----------------------
;; I love using ido-mode in Emacs.  The first part here automatically adds
;; newly opened files to the ido-mode cache and history.  This way, if we
;; open a file from the prompt via emacsclient or from a tag lookup we can
;; easily get back to it later via ido-mode.  The second part here is based
;; on bits from Emacswiki that extend ido-mode to most other places that
;; take input from the minibuffer.  This is awesome with tags and help!
;;
(require 'ido)
(ido-mode 1)
(add-hook 'find-file-hook 'ido-remember-buffer-file)
(defun ido-remember-buffer-file ()
  "Add this buffers file to the ido cache and history."
  (interactive)
  (let ((file (expand-file-name (buffer-file-name))))
    (if file
        (let ((dir (file-name-directory file))
              (name (file-name-nondirectory file)))
          (ido-record-work-file name)
          (ido-record-work-directory dir)
          (ido-file-name-all-completions dir)))))
(ido-everywhere 1)
(defadvice completing-read
  (around use-ido-when-possible activate)
  (if (not (boundp 'ido-cur-list))
      (let ((completions (all-completions "" collection predicate)))
        (if completions
            (setq ad-return-value
                  (ido-completing-read prompt completions nil require-match
                                       initial-input hist def)))))
  (unless ad-return-value
    ad-do-it))
(define-key global-map [(meta ?x)] 'ido-meta-x)
(defun ido-meta-x ()
  "Replacement for standard M-x that use ido."
  (interactive)
  (call-interactively
   (intern
    (or (completing-read "M-x " (all-completions "" obarray 'commandp))))))

;; Isearch
;; -------
;; Temporarily turn on which-function-mode during an interactive search and
;; make sure it shows up in our custom modeline.
;;
(defvar saved-which-function)
(add-hook 'isearch-mode-hook 'isearch-mode-start-which-func)
(defun isearch-mode-start-which-func ()
  "Start which-func mode and add it to the mode line."
  (setq saved-which-function which-function-mode)
  (nconc mode-line-format '((which-func-mode
                             (:propertize (" " which-func-current "()")
                                          face mode-line-emphasis))))
  (which-function-mode))
(add-hook 'isearch-mode-end-hook 'isearch-mode-end-which-func)
(defun isearch-mode-end-which-func ()
  "Stop which-func mode and clear it from the mode line."
  (which-function-mode (if saved-which-function 1 -1))
  (nbutlast mode-line-format))

(provide 'setup-ido)
