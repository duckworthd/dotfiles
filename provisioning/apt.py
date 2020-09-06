import os

from invoke import task
from provisioning import colors
from provisioning import core
from provisioning import utils


@task(core.dotfiles)
def ag(c):
  "Install ag, an improved grep."
  if utils.command_exists(c, 'ag'):
    return
  utils.apt_install(c, "silversearcher-ag")


@task
def cmake(c):
  """Install cmake, a tool for building from source."""
  if utils.command_exists(c, 'cmake'):
    return
  utils.apt_install(c, ["build-essential", "cmake"])


@task
def git(c):
  "Install git, a version control system."
  if utils.command_exists(c, 'git'):
    return
  utils.apt_install(c, "git")


@task(git)
def git_init_submodules(c):
  "Initialize all submodules in this repository."
  utils.print_run(c, "git submodule update --init --recursive", hide="out")


@task
def htop(c):
  "Install htop, a nicer version of top."
  if utils.command_exists(c, 'htop'):
    return
  utils.apt_install(c, "htop")


@task
def keepass2(c):
  """Install Keepass2, a password storage app."""
  if utils.command_exists(c, 'keepass2'):
    return
  utils.apt_install(c, "keepass2")

@task
def maestral(c):
  """Install maestral, an open source Dropbox client."""
  if os.path.exists(os.path.expanduser('~/.local/bin/maestral')):
    return
  utils.pip_install(c, "maestral")  # TODO(duckworthd): Re-enable maestral[gui] when "pip3 install PyQT5" works again.
  utils.print_run(c, "~/.local/bin/maestral autostart --yes", hide="out")


@task
def python3_dev(c):
  """Install Python 3 headers."""
  if utils.is_apt_installed(c, 'python3-dev'):
    return
  utils.apt_install(c, "python3-dev")


@task
def requests(c):
  """Install requests, a Python library for downloading URLs."""
  try:
    import requests
    return
  except ImportError:
    utils.pip_install(c, "requests")


@task
def xclip(c):
  "Install xclip, a tool for copying text from terminal to your clipboard."
  if utils.is_apt_installed(c, 'xclip'):
    return
  utils.apt_install(c, "xclip")


@task(git)
def fzf(c):
  """Install fzf, a fuzzy file finder."""
  if utils.command_exists(c, "fzf"):
    return

  if not os.path.exists(os.path.expanduser("~/.fzf")):
    utils.print_run(c, "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf")
  utils.print_run(c, "~/.fzf/install --all")


@task(git_init_submodules, core.dotfiles, cmake, python3_dev)
def neovim(c):
  "Install neovim, a text editor."
  if utils.command_exists(c, 'nvim'):
    return

  utils.apt_install(c, "neovim")

  # Install plugins with vim-plug.
  print(colors.OKRED + "Run :PlugInstall the next time you open vim to install plugins." + colors.ENDC)


@task(requests)
def tmux(c):
  """Install tmux, a terminal multiplexer, from source."""
  if os.path.exists(os.path.expanduser("~/bin/tmux")):
    return

  import requests

  # install dependencies.
  utils.apt_install(c, [
      "libevent-dev",
      "ncurses-dev",
      "build-essential",
      "bison",
      "pkg-config",
  ])

  # Downlaod tarball.
  response = requests.get(
      "https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b.tar.gz")
  tar_path = "/tmp/tmux.tar.gz"
  with open(tar_path, "wb") as tarfile:
    tarfile.write(response.content)

  # Extract its contents.
  utils.print_run(c, f"tar -zxf {tar_path} --directory /tmp", hide="out")

  with utils.chdir("/tmp/tmux-3.1b"):
    # Build it.
    utils.print_run(c, "./configure --enable-static", hide="out")
    utils.print_run(c, "make", hide="out")

    # Move it $HOME/bin.
    destination_dir = os.path.join(os.path.expanduser("~"), "bin")
    if not os.path.exists(destination_dir):
      os.makedirs(destination_dir)
    utils.print_run(c, f"cp ./tmux {destination_dir}/tmux", hide="out")

  print(colors.OKRED + "Run CTRL+b I the next time you open tmux to install plugins." + colors.ENDC)


@task(git_init_submodules, core.dotfiles)
def zsh(c):
  "Install zsh, an alternative to bash."
  if utils.command_exists(c, 'zsh'):
    return
  utils.apt_install(c, "zsh")
  utils.print_run(c, "chsh -s $(which zsh)")


@task(zsh)
def oh_my_zsh(c):
  """Installs oh-my-zsh, an extension suite for ZSH."""
  destination = os.path.expanduser("~/.oh-my-zsh")
  if os.path.exists(destination):
    return
  utils.print_run(c, 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')


@task(oh_my_zsh, git)
def powerlevel10k(c):
  """Installs powerlevel10k, a theme for oh-my-zsh."""
  source = "https://github.com/romkatv/powerlevel10k.git"
  destination = os.path.expanduser("~/.oh-my-zsh/custom/themes/powerlevel10k")
  if os.path.exists(destination):
    return
  utils.print_run(c, f"git clone --depth=1 {source} {destination}", hide="out")


@task(oh_my_zsh, git)
def zsh_syntax_highlighting(c):
  """Installs zsh-syntax-highlighting, an extension for oh-my-zsh."""
  source = "https://github.com/zsh-users/zsh-syntax-highlighting.git"
  destination = os.path.expanduser("~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting")
  if os.path.exists(destination):
    return
  utils.print_run(c, f"git clone --depth=1 {source} {destination}", hide="out")

@task
def meld(c):
  """Installs meld, a 3-way merge tool."""
  if utils.command_exists(c, 'meld'):
    return
  utils.apt_install(c, "meld")
