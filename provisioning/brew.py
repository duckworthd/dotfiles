"""Install with homebrew."""
import functools

from invoke import task

from . import brew
from . import core
from . import utils


def _brew_install_task(c, *, package):
  if utils.is_brew_installed(c, package):
    return
  utils.brew_install(c, package)


def _create_brew_install_task(package, dependencies=None):
  """Creates a new 'brew install <package>' rule."""
  dependencies = dependencies or []
  rule = functools.partial(_brew_install_task, package=package)
  rule = task(*dependencies)(rule)
  return rule


ag = _create_brew_install_task('ag', [core.dotfiles])
htop = _create_brew_install_task('htop')
keepassxc = _create_brew_install_task('keepassxc')
maestral = _create_brew_install_task('maestral')
python3 = _create_brew_install_task('python3')
fzf = _create_brew_install_task('fzf')
neovim = _create_brew_install_task('neovim', [core.dotfiles, core.git_init_submodules])
neovide = _create_brew_install_task('neovide')
tmux = _create_brew_install_task('tmux', [core.dotfiles])
zsh = _create_brew_install_task('zsh', [core.dotfiles, core.git_init_submodules])

@task(zsh)
def oh_my_zsh(c):
  """Installs oh-my-zsh, an extension suite for ZSH."""
  core.oh_my_zsh(c)


@task(oh_my_zsh)
def powerlevel10k(c):
  """Installs powerlevel10k, a theme for oh-my-zsh."""
  core.powerlevel10k(c)
