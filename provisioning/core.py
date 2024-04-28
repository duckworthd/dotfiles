"""Platform-independent tasks."""
import os

from invoke import task

from provisioning.utils import platform
from provisioning.utils import print_run


@task
def dotfiles(ctx):
  """symlink dotfiles to $HOME"""
  DOTFILE_ROOT = os.path.abspath(os.path.join(
      os.path.split(__file__)[0],
      "../dotfiles"
    ))
  HOME = os.environ["HOME"]

  def create_symlink(source, target):
    print_run(ctx, f'ln -s "{source}" "{target}"')

  def recursive_symlink_dotfiles(source, target):
    """Recursively explore directories, creating dirs/files on the way."""
    if not os.path.exists(target) and os.path.islink(target):
      # exists() returns False for broken symlinks. Remove the broken link.
      os.unlink(target)

    if os.path.exists(target) and os.path.isdir(source) and os.path.islink(target):
      print(f'Found symlinked dir. Skipping. {target}')
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
        print(f'Found dotfile. Skipping. {target}')
        pass 

      else:
        # If file doesn't exist, create a symlink.
        create_symlink(source, target)

  for fname in os.listdir(DOTFILE_ROOT):
    recursive_symlink_dotfiles(
        os.path.join(DOTFILE_ROOT, fname),
        os.path.join(HOME, "." + fname))

def oh_my_zsh(c):
  """Installs oh-my-zsh, an extension suite for ZSH."""
  destination = os.path.expanduser("~/.oh-my-zsh")
  if os.path.exists(destination):
    return
  print_run(c, 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')


def powerlevel10k(c):
  """Installs powerlevel10k, a theme for oh-my-zsh."""
  source = "https://github.com/romkatv/powerlevel10k.git"
  destination = os.path.expanduser("~/.oh-my-zsh/custom/themes/powerlevel10k")
  if os.path.exists(destination):
    return
  print_run(c, f"git clone --depth=1 {source} {destination}", hide="out")


@task
def git_init_submodules(c):
  """Initialize all git submodules in this repository."""
  print_run(c, "git submodule update --init --recursive", hide="out")
