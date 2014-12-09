# let autojump track my movement, enable the `j` command
if command_exists brew && [[ -s $(brew --prefix)/etc/autojump.zsh ]]; then
   . $(brew --prefix)/etc/autojump.zsh
fi
