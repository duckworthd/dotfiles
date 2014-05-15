# initalize rbenv
if hash rbenv 2> /dev/null; then
  eval "$(rbenv init -)"
fi

# initialize tmuxinator autocompletion
if [[ -e "~/.bin" ]] && [[ -e "~/.bin/tmuxinator.zsh" ]]; then
  source ~/.bin/tmuxinator.zsh
fi
