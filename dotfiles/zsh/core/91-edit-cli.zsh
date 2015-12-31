# Pressing C-x C-e allows user to edit command in the default editor.
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
