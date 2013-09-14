# Colors in Terminal.app
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Local bin/ path
export PATH=~/bin:$PATH

# Protect cp/rm/mv from automatically overwriting
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


# MacPorts Installer addition on 2011-08-26_at_19:38:00: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# tell SVN/Git to use VIM
export EDITOR=vim

# app-specific bashrc files
for f in `ls ~/.bashrcs/*`
do
  source $f
done

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# grep in color
export GREP_COLOR="1;33"
export GREP_OPTIONS="--color"

# tree better
export TREE_OPTIONS="-F --noreport --dirsfirst -A"
alias tree='tree $TREE_OPTIONS'

# utf8 everywhere
export LANG=en_US.UTF-8

# color when viewing logs
export LOGBACK_COLOR=true
