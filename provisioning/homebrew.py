import os

from invoke import task
from .utils import *


@task("homebrew")
def ctags():
  brew_install("ctags")

@task("virtualbox")
def docker():
  brew_install("boot2docker")
  brew_install("docker")

@task("homebrew")
def ack():
  brew_install("ack")

@task("homebrew")
def autojump():
  if brew_install("autojump"):
    print (
      """
      The following needs to be added to your .bash_profile or .zshrc,

      [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
      """
    )

@task("homebrew")
def wget():
  brew_install("wget")

@task("homebrew")
def htop():
  brew_install("htop-osx")

@task("python")
def httpie():
  if command_exists("http"): return
  pip_install("httpie")

@task("homebrew")
def jq():
  brew_install("jq")

@task("homebrew")
def mysql():
  HOME = os.environ["HOME"]
  brew_install("mysql")

  # register mysql with Launch Control to start on system startup
  source = '/usr/local/opt/mysql/homebrew.mxcl.mysql.plist'
  dest   = '{}/Library/LaunchAgents/homebrew.mxcl.mysql.plist'.format(HOME)
  if not os.path.exists(dest):
    run('ln -sfv {source} {dest}'.format(source=source, dest=dest))
  if 'homebrew.mxcl.mysql' not in run("launchctl list", hide="out").stdout:
    run('launchctl load {dest}'.format(dest))

@task("homebrew")
def parallel():
  brew_install("parallel")

@task("homebrew")
def python():
  brew_install("python")

@task("python")
def python_scientific():
  # scipy
  brew_install("gcc")

  # matplotlib
  brew_install("freetype")
  pip_install("pyparsing")

  # `pip install scipy` doesn't work with Homebrew due to path issues, so let
  # homebrew handle its installation instead.
  brew_tap("samueljohn/python")
  brew_install("numpy")
  brew_install("scipy")
  brew_install("matplotlib")

  pip_install(["pandas", "ipython", "ipdb"])

@task("python")
def python_productivity():
  brew_install("libevent")
  brew_install( "libyaml")
  brew_install( "libxml2")
  pip_install(         "PyYAML", check=lambda: python_package_exists("yaml"))
  pip_install("python-dateutil", check=lambda: python_package_exists("dateutil"))
  pip_install([
    "configurati",
    "duxlib",
    "funcy",
    "gevent",
    "invoke",
    "lxml",
    "virtualenv",
  ])

@task("python", "mysql")
def python_web():
  pip_install("MySQL-python", check=lambda: python_package_exists("MySQLdb"))
  pip_install([
    "sqlrest",
    "bottle",
    "pyjade",
    "jinja2",
  ])

@task("python")
def python_testing():
  pip_install([
    "nose",
  ])

@task("python")
def python_amazon():
  pip_install([
    "boto",
    "awscli",
  ])
  pip_install("gsutil", check=lambda: command_exists("gsutil"))

@task("homebrew")
def coreutils():
  brew_install("coreutils")

@task("homebrew")
def s3cmd():
  brew_install("s3cmd")

@task("homebrew")
def scala():
  brew_install("scala")

@task("homebrew", "dotfiles")
def tmux():
  brew_install("tmux")
  brew_install("reattach-to-user-namespace")

@task("homebrew")
def tree():
  brew_install("tree")

@task("homebrew", "dotfiles")
def zsh():
  if command_exists("zsh"): return
  brew_install("zsh")
  run('chsh -s $(which zsh)')

