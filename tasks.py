import os

from invoke import task
from provisioning.apps import *
from provisioning.core import *
from provisioning.homebrew import *


@task
def all(ctx):
  if platform() == "Darwin":
    homebrew(ctx)
    dotfiles(ctx)

    # CLI utils
    ack(ctx)
    autojump(ctx)
    coreutils(ctx)
    ctags(ctx)
    htop(ctx)
    httpie(ctx)
    jq(ctx)
    parallel(ctx)
    python(ctx)
    tmux(ctx)
    tree(ctx)
    zsh(ctx)

    # Applications
    alfred(ctx)
    chrome(ctx)
    dropbox(ctx)
    iterm2(ctx)
    keepassx(ctx)
    macvim(ctx)

  if platform() == "Linux":
    dotfiles(ctx)