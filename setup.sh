#!/usr/bin/env sh

set -e

platform=`uname`
if [[ "$platform" == "Darwin" ]]; then
  sudo easy_install invoke
  invoke "$@"
else
  echo "This script only works on Macs. Sorry."
  exit 1
fi
