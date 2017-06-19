#!/usr/bin/env bash
#
# This script uses "invoke", a Python package akin to Ruby's rake, to provision
# a system with standard apps duckworthd@ uses. If invoke isn't installed, it
# will attempt to install it via pip.

PLATFORM=$(uname)

# Installs pip globally if it's not available.
function install_pip_if_missing() {
  hash pip 2>/dev/null
  IS_PIP_AVAILABLE=$?

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
}

# Installs invoke globally if not available. Expects pip to be available.
function install_invoke_if_missing() {
  hash invoke 2>/dev/null
  IS_INVOKE_AVAILABLE=$?

  if [[ ${IS_INVOKE_AVAILABLE} -eq 0 ]]; then
    invoke --version | grep "0.16.3" 2>/dev/null
    IS_INVOKE_VERSION_CORRECT=$?
  fi


  if [[ ( ${IS_INVOKE_AVAILABLE} -eq 1 ) || ( ${IS_INVOKE_VERSION_CORRECT} -eq 1 ) ]]; then
    if [[ "${PLATFORM}" == "Linux" ]]; then
      sudo pip install 'invoke==0.16.3'
    elif [[ "${PLATFORM}" == "Darwin" ]]; then
      pip install 'invoke==0.16.3'
    else
      echo "Unrecognized OS: ${PLATFORM}. Please install invoke manually."
      exit 1
    fi
  fi
}

# Execute invoke with command line args.
install_pip_if_missing
install_invoke_if_missing
invoke "$@"
