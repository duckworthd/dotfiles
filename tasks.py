import os

from invoke import task
from provisioning import apps, core, homebrew


@task(default=True)
def common():
  core.homebrew()
  core.brew_cask()
  core.dotfiles()

  # CLI utils
  homebrew.ack()
  homebrew.autojump()
  homebrew.coreutils()
  homebrew.ctags()
  homebrew.htop()
  homebrew.httpie()
  homebrew.jq()
  homebrew.parallel()
  homebrew.python()
  homebrew.python_productivity()
  homebrew.python_scientific()
  homebrew.tmux()
  homebrew.tree()
  homebrew.zsh()

  # Applications
  apps.alfred()
  apps.chrome()
  apps.dropbox()
  apps.evernote()
  apps.gitx()
  apps.iterm2()
  apps.java()
  apps.keepassx()
  apps.macvim()
