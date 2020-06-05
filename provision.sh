#!/usr/bin/env bash
#
# This script uses "invoke", a Python package akin to Ruby's rake, to provision
# a system with standard apps duckworthd@ uses. If invoke isn't installed, it
# will attempt to install it via pip.

PLATFORM=$(uname)

# Installs pip globally if it's not available.
function install_pip_if_missing() {
  hash pip3 2>/dev/null
  IS_PIP_AVAILABLE=$?

  if [[ ${IS_PIP_AVAILABLE} -eq 1 ]]; then
    if [[ "${PLATFORM}" == "Linux" ]]; then
      sudo apt-get --yes install python3-pip
    else
      echo "Unrecognized OS: ${PLATFORM}. Please install pip3 manually."
      exit 1
    fi
  fi
}

# Installs invoke globally if not available. Expects pip to be available.
function install_invoke_if_missing() {
  hash invoke 2>/dev/null
  IS_INVOKE_AVAILABLE=$?

  if [[ ${IS_INVOKE_AVAILABLE} -eq 1 ]]; then
    if [[ "${PLATFORM}" == "Linux" ]]; then
      python3 -m pip install 'invoke'
    else
      echo "Unrecognized OS: ${PLATFORM}. Please install invoke manually."
      exit 1
    fi
  fi
}

# Execute invoke with command line args.
install_pip_if_missing
install_invoke_if_missing
python3 -m invoke "$@"
