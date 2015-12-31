# Path
PATH+=":/bin"
PATH+=":/sbin"
PATH+=":/usr/bin"
PATH+=":/usr/sbin"
PATH+=":$HOME/bin"
PATH+=":/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"
PATH+=":/usr/local/bin"
PATH+=":/usr/X11/bin"
PATH+=":/usr/texbin"
export PATH

# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# default pager, editor
export PAGER='less -R'
export EDITOR='vim'

# UTF8 in terminal
export LANG=en_US.UTF-8

# These characters, in addition to alphanumerics, are considered part of a
# "word". For example, since "-" is in this list, pressing <C-w> will delete
# all of "file-name", instead of just "name". Remove a character from this list
# if you want it to be considered a word separator.
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
