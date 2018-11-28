################################################################################
######################## duckworthd@'s fish config #############################
################################################################################
#
# Installation
# ============
#
# Requires fish 2.7 or greater.
# $ sudo apt-add-repository ppa:fish-shell/release-2
# $ sudo apt-get update
# $ sudo apt-get install fish

# Requires fisherman (https://github.com/fisherman/fisherman).
# $ curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
#
# Commands
# ========
# $ prevd  # go to previous directory in stack.
# $ nextd  # go to next directory in stack.
# C-t      # find path, insert into command line.
# C-r      # find previous command, insert into command line.
# A-c      # find path, cd into it.
# A-e      # open command in $EDITOR.

# Setup $PATH.
set -x PATH $HOME/bin $HOME/.local/bin $PATH
set -x EDITOR vim


# Use emacs-style command line editing.
set --global fish_key_bindings fish_default_key_bindings

# Aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# No greeting message.
set fish_greeting ""

# Swap caps lock, escape.
if type -q setxkbmap
  setxkbmap -option "caps:swapescape"
end

# Source machine-local fish config, if it exists.
set local_fish_config $HOME/.config/fish/config_local.fish
if test -e $local_fish_config
  source $local_fish_config
end

# Force 256 color support. If terminal emulator doesn't support 256
# colors, you're gonna have a bad time...
set --global --export TERM "xterm-256color"

# Disable right click on clickpad.
if type -q synclient
  synclient RightButtonAreaLeft=0 2> /dev/null
  synclient RightButtonAreaTop=0 2> /dev/null
end
