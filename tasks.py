import platform

from invoke import task

from provisioning import apt
from provisioning import brew
from provisioning import core


DEPENDENCIES = {
  'Linux': (
    core.dotfiles,
    apt.ag,
    apt.fzf,
    apt.git,
    apt.htop,
    apt.keepassx,
    apt.maestral,
    apt.meld,
    apt.neovim,
    apt.oh_my_zsh,
    apt.powerlevel10k,
    apt.tmux,
    apt.xclip,
    apt.zsh,
  ),
  'Darwin': (
    core.dotfiles,
    brew.ag,
    brew.discord,
    brew.firefox,
    brew.fzf,
    brew.htop,
    brew.keepassxc,
    brew.maestral,
    brew.neovim,
    brew.oh_my_zsh,
    brew.powerlevel10k,
    brew.tmux,
    brew.vlc,
    brew.zsh,
  )
}

if platform.system() not in DEPENDENCIES:
  raise NotImplementedError(f"Unrecognized platform: {platform.system()}")


@task(*DEPENDENCIES[platform.system()])
def all(c):
  """Install all dependencies."""
  print('All done!')
