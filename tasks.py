import os

from invoke import task
from provisioning.apps import *
from provisioning.core import *
from provisioning.homebrew import *


@task(default=True)
def common():
  homebrew()
  brew_cask()
  dotfiles()

  # CLI utils
  ack()
  autojump()
  coreutils()
  ctags()
  htop()
  httpie()
  jq()
  parallel()
  python()
  python_productivity()
  python_scientific()
  tmux()
  tree()
  zsh()

  # Applications
  alfred()
  chrome()
  dropbox()
  evernote()
  gitx()
  iterm2()
  java()
  keepassx()
  macvim()
