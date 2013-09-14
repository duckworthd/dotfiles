;;; Package Management {{{

  ;;; el-get {{{
    ; set directory containing initialization scripts
    (setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

    ; Load or install el-get
    (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
    (unless
      (require 'el-get nil 'noerror)
      (with-current-buffer
        (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
        (goto-char (point-max))
        (eval-print-last-sexp)))

    (el-get 'sync)

    ; Usage
    ; <M-x> el-get-install (package-name)   ; install package
    ; <M-x> el-get-remove (package-name)    ; delete package
    ; <M-x> el-get-update-all               ; update all installed packages
    ; <M-x> e-get-list-packages             ; list available packages
    ; <M-x> el-get-describe                 ; info about package
  ;;; }}}


  ;;; auto-complete {{{
    (add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
    (require 'auto-complete-config)

    ; tell auto-complete where to find its dictionary
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1/ac-dict")
    (ac-config-default)

    ; use this to enable combining python-mode's completion with auto-complete
    (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;;; }}}
;;; }}}

;;; Spacing {{{
  ; Set option key to meta in Aquamacs
  (setq mac-control-modifier 'ctrl)
  (setq mac-option-modifier 'meta)

  ; use spaces instead of tabs
  (setq-default indent-tabs-mode nil)
  ; use 2-space tabs
  (setq-default tab-width 2)
  (setq-default c-basic-indent 2)
;;; }}}

;;; Appearance {{{

;;; }}}

;;; Behaviour {{{
  (defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
    "Prevent annoying \"Active processes exist\" query when you quit Emacs."
    (flet ((process-list ())) ad-do-it))

  ; ; always show line numbers
  ; (global-linum-mode t)

  ; don't show welcoem screen
  (setq inhibit-splash-screen t)

  ;disable backups and auto-saves
  (setq backup-inhibited t)
  (setq auto-save-default nil)
;;; }}}

;;; Key Bindings {{{

  ; use <C-c> <arrow key> to navigate frames
  (global-set-key (kbd "C-c h")  'windmove-left)
  (global-set-key (kbd "C-c l") 'windmove-right)
  (global-set-key (kbd "C-c k")    'windmove-up)
  (global-set-key (kbd "C-c j")  'windmove-down)

  ; use <M-Up> and <M-Down> to shift frame by 3 lines
  (global-set-key (kbd "M-<up>")
                  (lambda() (interactive) (scroll-down-line 3)))
  (global-set-key (kbd "M-<down>")
                  (lambda() (interactive) (scroll-up-line   3)))
;;; }}}

;;; Plugins {{{
  ; see ~/.emacs.d/el-get-init-files/init-*.el
;;; }}}
