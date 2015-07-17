# Mac copy/paste doesn't work if you launch MacVim without this
if command_exists reattach-to-user-namespace; then
  for cmd (vim mvim pbcopy pbpaste nohup launchctl); do
    alias $cmd="reattach-to-user-namespace $cmd"
  done
fi

# Run this function from within tmux to update environment variables in the
# tmux session. This is critical to keeping ssh forwarding and xclip working
# when re-attaching to a tmux session.
tmux-update-environment () {
   echo -n "Updating to latest tmux environment...";
    export IFS=",";
    for line in $(tmux showenv -t $(tmux display -p "#S") | tr "\n" ",");
    do
        if [[ $line == -* ]]; then
            unset $(echo $line | cut -c2-);
        else
            export $line;
        fi;
    done;
    unset IFS;
    echo "Done"
}
