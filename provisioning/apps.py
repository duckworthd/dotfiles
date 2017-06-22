import os

from invoke import task
from .core import dotfiles, homebrew, xcode
from .homebrew import ctags
from .utils import *


@task(homebrew)
def alfred(ctx):
  if application_exists(ctx, "Alfred 2"): return
  brew_install(ctx, "alfred2", cask=True)

@task(homebrew)
def chrome(ctx):
  if application_exists(ctx, "Google Chrome"): return
  brew_install(ctx, "google-chrome", cask=True)

@task(homebrew)
def dropbox(ctx):
  if application_exists(ctx, "Dropbox"): return
  brew_install(ctx, "dropbox", cask=True)

@task(homebrew)
def iterm2(ctx):
  if application_exists(ctx, "iTerm"): return
  brew_install(ctx, "iterm2", cask=True)

@task(homebrew)
def mosh(ctx):
  brew_install(ctx, "mosh", cask=True)

@task(homebrew)
def keepassx(ctx):
  if application_exists(ctx, "KeePassX"): return
  brew_install(ctx, "keepassx", cask=True)

@task(homebrew, xcode, ctags, dotfiles)
def macvim(ctx):
  if command_exists(ctx, "mvim"): return
  HOME = os.environ["HOME"]
  brew_install(ctx, "macvim", flags=["--with-lua", "--with-python3", "--with-override-system-vim"])
  print "Type ':PluginInstall' the next time you open vim"

@task(homebrew, dotfiles)
def mjolnir(ctx):
  if application_exists(ctx, "Mjolnir"): return
  brew_install(ctx, "mjolnir", cask=True)

  # extensions I use in mjolnir's config
  extensions = [
    'application',
    'hotkey',
    'tiling',
  ]
  for ext in extensions:
    luarocks_install(ctx, "mjolnir.{}".format(ext))

@task(homebrew)
def xquartz(ctx):
  if application_exists(ctx, "Utilities/XQuartz"): return
  brew_install(ctx, "xquartz", cask=True)

@task(homebrew, xquartz)
def R(ctx):
  brew_tap(ctx, "homebrew/science")
  brew_install(ctx, "R")

@task(homebrew)
def vlc(ctx):
  if application_exists(ctx, "VLC"): return
  brew_install(ctx, "vlc", cask=True)

@task(homebrew)
def spotify(ctx):
  if application_exists(ctx, "Spotify"): return
  brew_install(ctx, "spotify", cask=True)
