#!/usr/bin/env sh

function show() {
  echo "$ $@"
  $@
}

PROJECT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

echo 'Linking dotfiles to HOME'
for FNAME in $(find $PROJECT_DIR -name ".[^.]*" -maxdepth 1); do
  show ln -s $FNAME ~/$(basename $FNAME)
done
