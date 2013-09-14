# black magic to check if aws_zsh_completer.sh is a valid command; if so, reference it
if hash aws_zsh_completer.sh 2>/dev/null; then
  source $(which aws_zsh_completer.sh)
fi
