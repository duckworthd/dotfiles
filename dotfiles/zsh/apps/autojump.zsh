# let autojump track my movement, enable the `j` command

# for mac
if command_exists brew && [[ -s $(brew --prefix)/etc/autojump.zsh ]]; then
   . $(brew --prefix)/etc/autojump.zsh
fi

# for ubuntu
if [[ -s /usr/share/autojump/autojump.zsh ]]; then
  . /usr/share/autojump/autojump.zsh
fi
