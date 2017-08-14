if [[ "$(uname)" = "Linux" ]] && command_exists synclient; then
  # Disable right click on touchpads
  synclient RightButtonAreaLeft=0
  synclient RightButtonAreaTop=0
fi
