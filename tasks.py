from invoke import task
from provisioning import apt
from provisioning import core
from provisioning import utils

from provisioning.apt import *
from provisioning.core import *

@task(
  apt.ag,
  core.dotfiles,
  apt.fzf,
  apt.git,
  apt.htop,
  apt.keepass2,
  apt.maestral,
  apt.neovim,
  apt.tmux,
  apt.xclip,
  apt.zsh,
)
def all(c):
  "Install all recommended packages."
  pass
