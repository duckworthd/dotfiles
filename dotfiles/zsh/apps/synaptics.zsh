if [[ "$(uname)" = "Linux" ]] && command_exists synclient; then
  # Disable right click on touchpads. If there is no synpatics driver loaded,
  # this typically prints to stderr. We hide that here.
  synclient RightButtonAreaLeft=0 2> /dev/null
  synclient RightButtonAreaTop=0 2> /dev/null
fi
