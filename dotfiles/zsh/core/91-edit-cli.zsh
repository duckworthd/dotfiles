autoload -z edit-command-line
zle -N edit-command-line

# Press C-x C-e allows user to edit command in the default editor if using
# emacs style key bindings.
bindkey "^X^E" edit-command-line

# Press Esc-v for the same with vim-style bindings.
bindkey -M vicmd v edit-command-line
