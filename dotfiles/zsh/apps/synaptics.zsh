# Synaptics Touchpad configuration.

if command_exists synclient; then
  # Disable right-click via touchpad
  synclient RightButtonAreaLeft=0 2> /dev/null
  synclient RightButtonAreaTop=0 2> /dev/null

  # Disable scrolling after letting go of the touchpad.
  synclient CoastingSpeed=0 2> /dev/null
fi
