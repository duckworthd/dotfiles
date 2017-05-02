import os

from invoke import task
from .core import dotfiles, homebrew
from .utils import *



@task(homebrew)
def python(ctx):
  brew_install(ctx, "python")

@task(homebrew)
def ack(ctx):
  brew_install(ctx, "ack")

@task(homebrew)
def autojump(ctx):
  if brew_install(ctx, "autojump"):
    print (
      """
      The following needs to be added to your .bash_profile or .zshrc,

      [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
      """
    )

@task(homebrew)
def coreutils(ctx):
  brew_install(ctx, "coreutils")

@task(homebrew)
def ctags(ctx):
  brew_install(ctx, "ctags")

@task(homebrew)
def htop(ctx):
  brew_install(ctx, "htop-osx")

@task(python)
def httpie(ctx):
  if command_exists(ctx, "http"): return
  pip_install(ctx, "httpie")

@task(homebrew)
def jq(ctx):
  brew_install(ctx, "jq")

@task(homebrew)
def lua(ctx):
  brew_install(ctx, "lua")

@task(lua)
def luarocks(ctx):
  brew_install(ctx, "luarocks")

@task(homebrew)
def parallel(ctx):
  brew_install(ctx, "parallel")

@task(python)
def python_scientific(ctx):
  # scipy
  brew_install(ctx, "gcc")

  # matplotlib
  brew_install(ctx, "freetype")
  pip_install(ctx, "pyparsing")

  # `pip install scipy` doesn't work with Homebrew due to path issues, so let
  # homebrew handle its installation instead.
  brew_tap("homebrew/python")
  brew_install(ctx, "numpy")
  brew_install(ctx, "scipy")
  brew_install(ctx, "matplotlib")

  pip_install(ctx, ["pandas", "ipython", "ipdb"])


@task(homebrew, dotfiles)
def tmux(ctx):
  brew_install(ctx, "tmux")
  brew_install(ctx, "reattach-to-user-namespace")

@task(homebrew)
def tree(ctx):
  brew_install(ctx, "tree")

@task(homebrew)
def wget(ctx):
  brew_install(ctx, "wget")

@task(homebrew, dotfiles)
def zsh(ctx):
  if "zsh" in brew_installed(ctx): return
  brew_install(ctx, "zsh")

  # "chsh -s" complains unless the path of the shell is in /etc/shells. Add it here.
  print_run(ctx, 'sudo sh -c "echo $(which zsh) >> /etc/shells"')

  print_run(ctx, 'chsh -s $(which zsh)')
