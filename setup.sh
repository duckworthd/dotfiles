#!/usr/bin/env sh -xe

# show command, then execute it
function show() {
  echo "$ $@"
  $@
}

function cmd_exists() {
  return command -v "$1" >/dev/null 2>&1
}

# full path to directory containing this file
PROJECT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

echo 'Linking dotfiles to HOME'
# for each dotfile in this directory...
for FNAME in $(find $PROJECT_DIR \
                    -name ".[^.]*" \
                    -maxdepth 1 \
                    \( ! -iname ".git*" -or -iname '.dropbox' \)
              ); do
  OUTPUT=$HOME/$(basename "$FNAME")
  # if $OUTPUT isn't a file or a directory
  if [ ! -f "$OUTPUT" ] && [ ! -d "$OUTPUT" ]; then
    # softlink $FNAME to $OUTPUT
    show ln -s "$FNAME" "$OUTPUT"
  fi
done

# install dependencies
show source $PROJECT_DIR/installs/homebrew.sh
show source $PROJECT_DIR/installs/wget.sh
show source $PROJECT_DIR/installs/xcode.sh

# install desktop apps
show source $PROJECT_DIR/installs/alfred.sh
show source $PROJECT_DIR/installs/chrome.sh
show source $PROJECT_DIR/installs/dropbox.sh
show source $PROJECT_DIR/installs/evernote.sh
show source $PROJECT_DIR/installs/hipchat.sh
show source $PROJECT_DIR/installs/java.sh
show source $PROJECT_DIR/installs/keepassx.sh
show source $PROJECT_DIR/installs/macvim.sh
show source $PROJECT_DIR/installs/slate.sh

# install CLI apps
show source $PROJECT_DIR/installs/ack.sh
show source $PROJECT_DIR/installs/htop.sh
show source $PROJECT_DIR/installs/jq.sh
show source $PROJECT_DIR/installs/mysql.sh  # python.sh depends on this
show source $PROJECT_DIR/installs/python.sh
show source $PROJECT_DIR/installs/R.sh
show source $PROJECT_DIR/installs/scala.sh
show source $PROJECT_DIR/installs/tmux.sh
show source $PROJECT_DIR/installs/zsh.sh
