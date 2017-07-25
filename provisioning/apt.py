import os

from invoke import task
from .core import dotfiles
from .utils import *


@task
def git(ctx):
  "Install git, a version control system."
  apt_install(ctx, "git")


@task(git)
def git_init_submodules(ctx):
  "Initialize all submodules in this repository."
  print_run(ctx, "git submodule update --init --recursive", hide="out")


@task
def ctags(ctx):
  "Install ctags, a tool for navigating source code semantically."
  apt_install(ctx, "exuberant-ctags")


@task
def ack(ctx):
  "Install ack, a tool for navigating source code semantically."
  apt_install(ctx, "ack-grep")


@task
def xclip(ctx):
  "Install xclip, a tool for copying text from terminal to your clipboard."
  apt_install(ctx, "xclip")


@task(git_init_submodules, dotfiles)
def zsh(ctx):
  "Install zsh, an alternative to bash."
  apt_install(ctx, "zsh")

  # Make zsh the primary shell.
  sudo_print_run(ctx, "chsh -s $(which zsh)")


@task
def cmake(ctx):
  """Install cmake, a tool for building from source."""
  apt_install(ctx, ["build-essential", "cmake"])


@task
def python_dev(ctx):
  """Install python-dev, headers for compiling Python."""
  apt_install(ctx, ["python-dev", "python3-dev"])


@task(git_init_submodules, ctags, dotfiles, cmake, python_dev)
def vim(ctx):
  "Install vim, a text editor."
  apt_install(ctx, "vim-gnome")

  # Install plugins with Vundle.
  print_run(ctx, "vim -c ':PluginInstall' -c 'qa!'", hide="both")

  # Build YouCompleteMe, a semantic autocompletion plugin.
  print_run(ctx, "$HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer", hide="out")


@task(dotfiles)
def xmonad(ctx):
  "Install xmonad, an alternative window manager to gnome."
  apt_install(ctx, ["xmonad", "xmobar", "stalonetray", "suckless-tools"])


@task
def terminator(ctx):
  "Install Terminator, a terminal emulator."
  apt_install(ctx, "terminator")


@task
def requests(ctx):
  pip_install(ctx, "requests")


@task(requests)
def tmux(ctx):
  """Install tmux, a terminal multiplexer, from source."""
  import requests

  # install dependencies.
  apt_install(ctx, ["libevent-dev", "libncurses5-dev"])

  # Downlaod tarball.
  tar_path = "/tmp/tmux.tar.gz"
  with open(tar_path, "w") as tarfile:
    response = requests.get(
        "https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz")
    tarfile.write(response.content)

  # Extract its contents.
  print_run(ctx, "tar zxf {} --directory /tmp".format(tar_path), hide="out")

  current_dir = os.getcwd()
  try:
    os.chdir("/tmp/tmux-2.5")

    # Build it.
    print_run(ctx, "./configure", hide="out")
    print_run(ctx, "make", hide="out")

    # Move it $HOME/bin.
    destination_dir = os.path.join(os.path.expanduser("~"), "bin")
    if not os.path.exists(destination_dir):
      os.makedirs(destination_dir)
    print_run(ctx, "cp ./tmux {}/tmux".format(destination_dir), hide="out")
  finally:
    os.chdir(current_dir)
