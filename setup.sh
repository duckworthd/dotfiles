#!/usr/bin/env sh

# show command, then execute it
function show() {
  echo "$ $@"
  $@
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
  OUTPUT=~/$(basename "$FNAME")
  # if $OUTPUT isn't a file or a directory
  if [ ! -f "$OUTPUT" ] && [ ! -d "$OUTPUT" ]; then
    # softlink $FNAME to $OUTPUT
    show ln -s "$FNAME" "$OUTPUT"
  fi
done
