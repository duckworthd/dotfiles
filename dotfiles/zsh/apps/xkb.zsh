if [[ "$(uname)" = "Linux" ]] && command_exists setxkbmap; then
  # turn <Caps Lock> becomes <Esc>
  setxkbmap \
    -option \
    -option caps:swapescape
fi
