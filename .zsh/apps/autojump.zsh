# let autojump track my movement, enable the `j` command
if command_exists brew; then
  [[ -s $(brew --prefix)/etc/autojump.sh ]] && . $(brew --prefix)/etc/autojump.sh
fi
