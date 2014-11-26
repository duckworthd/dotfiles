import os
import sys

from invoke import task

from .utils import *


@task
def dotfiles():
  """symlink dotfiles to $HOME"""
  DOTFILE_ROOT = os.path.abspath(os.path.join(
      os.path.split(__file__)[0],
      "../dotfiles"
    ))
  HOME = os.environ["HOME"]
  sources = os.listdir(DOTFILE_ROOT)

  for fname in sources:
    source = os.path.join(DOTFILE_ROOT,       fname)
    target = os.path.join(        HOME, "." + fname)
    if not os.path.exists(target):
      run('ln -s "{}" "{}"'.format(source, target))

@task
def homebrew():
  if command_exists("brew"): return
  if platform() != "Darwin":
    raise Exception(
      'You cannot install Homebrew on a non-OSX system. Any provisioning '
      'requiring Homebrew will fail.'
    )
  run('ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
  run("brew update")

@task("homebrew")
def brew_cask():
  if command_exists("brew cask"): return
  brew_install("caskroom/cask/brew-cask")

@task
def xcode():
  if application_exists("Xcode"): return
  run('open "https://developer.apple.com/downloads/index.action"')
  print (
    "Download and install XCode and Command Line Tools (press ENTER when done)"
  )

@task("xcode")
def xcode_license():
  run("sudo xcodebuild -license")

def platform():
  return sys.platform.capitalize()
