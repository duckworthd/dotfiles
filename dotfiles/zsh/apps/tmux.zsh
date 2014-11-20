# Mac copy/paste doesn't work if you launch MacVim without this
if command_exists reattach-to-user-namespace; then
  for cmd (vim mvim pbcopy pbpaste nohup launchctl); do
    alias $cmd="reattach-to-user-namespace $cmd"
  done
fi
