import os

from invoke import task

from .utils import application_exists
from .utils import command_exists
from .utils import platform
from .utils import print_run


@task
def dotfiles(ctx):
  """symlink dotfiles to $HOME"""
  DOTFILE_ROOT = os.path.abspath(os.path.join(
      os.path.split(__file__)[0],
      "../dotfiles"
    ))
  HOME = os.environ["HOME"]

  def create_symlink(source, target):
    print_run(ctx, 'ln -s "{}" "{}"'.format(source, target))

  def recursive_symlink_dotfiles(source, target):
    """Recursively explore directories, creating dirs/files on the way."""
    if not os.path.exists(target) and os.path.islink(target):
      # exists() returns False for broken symlinks. Remove the broken link.
      os.unlink(target)

    if os.path.exists(target) and os.path.isdir(source) and os.path.islink(target):
      print 'Found symlinked dir. Skipping. {}'.format(target)
      # Don't modify symlinked directories.
      return

    if os.path.isdir(source):
      # If the directory is missing, create one symlink for all of its contents.
      if not os.path.exists(target):
        create_symlink(source, target)
        return

      # Directory already exists. Create a symlink for files underneath it.
      for fname in os.listdir(source):
        recursive_symlink_dotfiles(
            os.path.join(source, fname),
            os.path.join(target, fname))

    else:
      if os.path.exists(target):
        # If file exists, don't replace it.
        print 'Found dotfile. Skipping.: {}'.format(target)

      else:
        # If file doesn't exist, create a symlink.
        print
        create_symlink(source, target)

  for fname in os.listdir(DOTFILE_ROOT):
    recursive_symlink_dotfiles(
        os.path.join(DOTFILE_ROOT, fname),
        os.path.join(HOME, "." + fname))


@task
def homebrew(ctx):
  """Install homebrew, a package manager for OSX."""
  if platform() != "Darwin":
    raise Exception(
      'You cannot install Homebrew on a non-OSX system. Any provisioning '
      'requiring Homebrew will fail.'
    )
  if not command_exists(ctx, "brew"):
    print_run(ctx, 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
  print_run(ctx, "brew update")


@task
def xcode(ctx):
  """Install xcode, build tools for OSX."""
  if platform() != "Darwin":
    raise Exception('You cannot install XCode on a non-OSX system.')
  if application_exists(ctx, "Xcode"):
    return
  print_run(ctx, 'open "https://developer.apple.com/downloads/index.action"')
  print (
    "Download and install XCode and Command Line Tools (press ENTER when done)"
  )


@task(xcode)
def xcode_license(ctx):
  """Sign the xcode license."""
  print_run(ctx, "sudo xcodebuild -license")
