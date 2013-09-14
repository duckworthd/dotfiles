#!/usr/bin/env sh

# show command, then execute it
function show() {
  echo "$ $@"
  $@
}

# full path to directory containing this file
PROJECT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

echo 'Linking dotfiles to HOME'
for FNAME in $(find $PROJECT_DIR \
                    -name ".[^.]*" \
                    -maxdepth 1 \
                    \( ! -iname ".git*" -or -iname '.dropbox' \) 
              ); do
  show ln -s $FNAME ~/$(basename $FNAME)
done
