#!/usr/bin/env sh

set -e

if [[ "$(uname)" == "Darwin" ]]; then
  sudo easy_install 'invoke==0.7.0'
  invoke "$@"
else
  echo "This script only works on Macs. Sorry."
  exit 1
fi
