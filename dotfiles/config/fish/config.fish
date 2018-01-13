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
#
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

# Setup $PATH
set -gx PATH $HOME/bin $HOME/anaconda2/bin $PATH

# Use vim for command line editor.
set EDITOR (which vim)" -u NONE"

# Use vim-style command line editing.
set -g fish_key_bindings fish_vi_key_bindings

# Aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# No greeting message.
set fish_greeting ""
