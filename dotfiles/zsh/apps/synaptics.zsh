# Synaptics Touchpad configuration.

if command_exists synclient; then
  # Disable right-click via touchpad
  synclient RightButtonAreaLeft=0
  synclient RightButtonAreaTop=0

  # Disable scrolling after letting go of the touchpad.
  synclient CoastingSpeed=0
fi
