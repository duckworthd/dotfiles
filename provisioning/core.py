import os

from invoke import task

from .utils import *


@task
def dotfiles():
  """symlink dotfiles to $HOME"""
  PROJECT_ROOT = os.path.split(__file__)[0]
  HOME         = os.environ["HOME"]
  sources = (
    run(
      'find "{}" -name ".[^.]*" -maxdepth 1'.format(PROJECT_ROOT),
      hide='out'
    )
    .stdout
    .strip()
    .split("\n")
  )

  for source in sources:
    if source.endswith(".dropbox"):
      continue
    if ".git" in source:
      continue

    target = os.path.join(HOME, os.path.split(source)[1])
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
  run('ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"')
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
