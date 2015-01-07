
if command_exists trash-put && [ ! -e "$HOME/.at_google" ]; then
  alias rm="trash-put"
fi
