"""Install with homebrew."""
import functools

from invoke import task

from . import colors
from . import core
from . import utils


def _brew_install_task(c, *, package, message=None):
  if utils.is_brew_installed(c, package):
    return
  utils.brew_install(c, package)
  if message:
    print(colors.OKRED + message + colors.ENDC)


def _create_brew_install_task(package, dependencies=None, message=None):
  """Creates a new 'brew install <package>' rule."""
  dependencies = [core.homebrew] + (dependencies or [])
  rule = functools.partial(_brew_install_task,
                           package=package,
                           message=message)
  rule = task(*dependencies)(rule)
  return rule


ag = _create_brew_install_task('ag', dependencies=[core.dotfiles])
discord = _create_brew_install_task('discord')
firefox = _create_brew_install_task('firefox')
fzf = _create_brew_install_task('fzf')
htop = _create_brew_install_task('htop')
keepassxc = _create_brew_install_task('keepassxc')
maestral = _create_brew_install_task('maestral')
neovide = _create_brew_install_task(
    'neovide', dependencies=[core.dotfiles, core.git_init_submodules])
neovim = _create_brew_install_task(
    'neovim',
    dependencies=[core.dotfiles, core.git_init_submodules],
    message='Run :PlugInstall the next time you open vim to install plugins.')
python3 = _create_brew_install_task('python3')
tmux = _create_brew_install_task(
    'tmux', [core.dotfiles],
    message='Run CTRL+b I the next time you open tmux to install plugins.')
vlc = _create_brew_install_task('vlc')
zsh = _create_brew_install_task('zsh',
                                [core.dotfiles, core.git_init_submodules])


@task(zsh)
def oh_my_zsh(c):
  """Installs oh-my-zsh, an extension suite for ZSH."""
  core.oh_my_zsh(c)


@task(oh_my_zsh)
def powerlevel10k(c):
  """Installs powerlevel10k, a theme for oh-my-zsh."""
  core.powerlevel10k(c)
