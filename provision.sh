#!/usr/bin/env sh
#
# This script uses "invoke", a Python package akin to Ruby's rake, to provision
# a system with standard apps duckworthd@ uses.

set -e

sudo easy_install 'invoke==0.16.3'
invoke "$@"
