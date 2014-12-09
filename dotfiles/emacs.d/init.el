(add-to-list 'load-path "~/.emacs.d/init.d/")

(require 'setup-environment)
(require 'setup-packages)
(require 'setup-keybindings)

(when (file-exists-p "~/.emacs.d-local/init.el")
  (load-file "~/.emacs.d-local/init.el"))
