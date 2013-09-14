# Mac copy/paste doesn't work if you launch MacVim without this
for cmd (vim mvim pbcopy pbpaste nohup launchctl); do
  alias $cmd="reattach-to-user-namespace $cmd"
done
