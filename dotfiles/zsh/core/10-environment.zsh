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
export PAGER='less'
export EDITOR='vim'

# UTF8 in terminal
export LANG=en_US.UTF-8
