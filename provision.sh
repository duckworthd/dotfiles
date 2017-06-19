#!/usr/bin/env bash
#
# This script uses "invoke", a Python package akin to Ruby's rake, to provision
# a system with standard apps duckworthd@ uses. If invoke isn't installed, it
# will attempt to install it via pip.

PLATFORM=$(uname)

hash pip 2>/dev/null
IS_PIP_AVAILABLE=$?

hash invoke 2>/dev/null
IS_INVOKE_AVAILABLE=$?

# Install invoke if it's missing
if [[ ${IS_INVOKE_AVAILABLE} -eq 1 ]]; then

  # Install pip if it's missing.
  if [[ ${IS_PIP_AVAILABLE} -eq 1 ]]; then
    if [[ "${PLATFORM}" == "Linux" ]]; then
      sudo apt-get --yes install python-pip
    elif [[ "${PLATFORM}" == "Darwin" ]]; then
      brew install python
    else
      echo "Unrecognized OS: ${PLATFORM}. Please install pip manually."
      exit 1
    fi
  fi

  pip install 'invoke==0.16.3'
fi

invoke "$@"
