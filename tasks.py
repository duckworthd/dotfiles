from invoke import task
from provisioning import apt
from provisioning import core
from provisioning import utils

from provisioning.apt import *
from provisioning.core import *

@task(
  core.dotfiles,
  apt.ag,
  apt.fzf,
  apt.git,
  apt.htop,
  apt.keepass2,
  apt.maestral,
  apt.meld,
  apt.neovim,
  apt.oh_my_zsh,
  apt.powerlevel10k,
  apt.tmux,
  apt.xclip,
  apt.zsh,
  apt.zsh_syntax_highlighting,
)
def all(c):
  "Install all recommended packages."
  pass
