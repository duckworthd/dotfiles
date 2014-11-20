# black magic to check if aws_zsh_completer.sh is a valid command; if so, reference it
if command_exists aws_zsh_completer.sh; then
  source $(which aws_zsh_completer.sh)
fi
