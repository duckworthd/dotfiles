import os
import sys

from invoke import task

from .utils import *


@task
def dotfiles(ctx):
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
      print_run(ctx, 'ln -s "{}" "{}"'.format(source, target))
    else:
      print 'Already found dotfile @ {}'.format(target)

@task
def homebrew(ctx):
  if platform(ctx) != "Darwin":
    raise Exception(
      'You cannot install Homebrew on a non-OSX system. Any provisioning '
      'requiring Homebrew will fail.'
    )
  if not command_exists(ctx, "brew"):
    print_run(ctx, 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
  print_run(ctx, "brew update")

@task
def xcode(ctx):
  if platform(ctx) != "Darwin":
    raise Exception('You cannot install XCode on a non-OSX system.')
  if application_exists(ctx, "Xcode"): 
    return
  print_run(ctx, 'open "https://developer.apple.com/downloads/index.action"')
  print (
    "Download and install XCode and Command Line Tools (press ENTER when done)"
  )

@task(xcode)
def xcode_license(ctx):
  print_run(ctx, "sudo xcodebuild -license")

def platform(ctx):
  return sys.platform.capitalize()