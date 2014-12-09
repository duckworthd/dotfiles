;; ===========================================================================
;; Internal Settings
;; ===========================================================================

(require 'setup-variables)

(setq-default
  inhibit-startup-screen t                        ; Skip the startup screens
  initial-scratch-message nil
  blink-cursor-alist '((t . hollow))              ; Cursor blinks solid and hollow
  frame-title-format '(buffer-file-name "%f" "%b") ; I know it's Emacs; show something useful
  mode-line-format '(" %+ "                       ; Simplify the mode line
                     (:propertize "%b" face mode-line-buffer-id)
                     ":%l:%c %[" mode-name "%]"
                     (-2 "%n")
                     (visual-line-mode " W")
                     (auto-fill-function " F")
                     (overwrite-mode " O"))
  max-mini-window-height 1                        ; Bouncy minibuffer/echo gets obnoxious
  truncate-lines t                                ; Truncate lines, don't wrap
  default-truncate-lines t
  vc-make-backup-files t                          ; Keep numbered backups in ~/.saves
  version-control t
  delete-old-versions t
  kept-new-versions 4
  kept-old-versions 0
  backup-directory-alist `((".*" . , tmp-dir))    ; save backups + autosave in tmp-dir
  auto-save-file-name-transforms `((".*", tmp-dir t))
  auto-save-list-file-prefix tmp-dir
  font-lock-use-fonts '(or (mono) (grayscale))    ; Maximal syntax highlighting
  font-lock-use-colors '(color)
  font-lock-maximum-decoration t
  font-lock-maximum-size nil
  font-lock-auto-fontify t
  show-paren-style 'parenthesis                   ; Highlight parenthesis
  comment-empty-lines t                           ; Prefix empty lines too
  show-trailing-whitespace t                      ; Show trailing whitespace
  use-dialog-box nil                              ; Always use the minibuffer for prompts
  user-full-name "Daniel Duckworth"
  user-mail-address "***@*****.***"
  query-user-mail-address nil
  display-warning-minimum-level 'error            ; Turn off annoying warning messages
  disabled-command-function nil                   ; Don't second-guess advanced commands
  delete-key-deletes-forward t                    ; Make delete key work normally
  kill-read-only-ok t                             ; Silently copy in read-only buffers
  column-number-mode t                            ; Display line and column numbers
  line-number-mode t
  tab-width 2                                     ; 2-space tabs
  tab-stop-list (number-sequence 2 120 2)
  indent-tabs-mode nil                            ; Use spaces only, no tabs
  tabify-regexp "^\t* [ \t]+"                     ; Tabify only initial whitespace
  minibuffer-max-depth nil                        ; Mini-buffer settings
  toolbar-print-function 'ps-print-buffer-with-faces ; Set the print button to print nice PS
  fill-column 80                                  ; Wrap lines at 75th column
  initial-major-mode 'text-mode                   ; Text mode, not Elisp
  case-fold-search t                              ; Fold case on searches
  buffers-menu-sort-function 'sort-buffers-menu-by-mode-then-alphabetically ; Buffers menu settings
  buffers-menu-grouping-function 'group-buffers-menu-by-mode-then-alphabetically
  buffers-menu-submenus-for-groups-p t
  ibuffer-default-sorting-mode 'filename/process  ; Group buffers primarily by directory
  uniquify-buffer-name-style 'forward             ; Prepend unique dirs when names clash
  uniquify-after-kill-buffer-p t
  uniquify-ignore-buffers-re "^\\*"
  ispell-program-name "aspell"                    ; Use aspell to spell check
  gdb-many-windows t                              ; Show GUD in all its glory
  ediff-split-window-function 'split-window-horizontally ; Show diffs side-by-side
  diff-switches "-u"                              ; Prefer unified over context diffs
  org-support-shift-select t                      ; Don't nuke shift selection in org-mode
  calc-display-sci-low -5                         ; More zeros before scientific notation
  max-lisp-eval-depth 10000                       ; Let elisp recurse further
  debug-on-error nil                              ; emacs backtrace on error
  scroll-margin 2                                 ; smooth scrolling
  scroll-conservatively 2
  )
(set-frame-parameter nil 'alpha 90)                           ; Make the window 90% opaque

(if (featurep 'mswindows)
  ; If we're on Windows, write files with CR/LF
  (set-default-buffer-file-coding-system 'raw-text-dos))

(provide 'setup-environment)
