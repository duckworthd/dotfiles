import contextlib
import getpass
import os

import invoke
from invoke import task

from .colors import *

__all__ = [
    'application_exists',
    'apt_install',
    'brew_install',
    'brew_installed',
    'brew_tap',
    'chdir',
    'command_exists',
    'luarocks_install',
    'pip_install',
    'platform',
    'python_package_exists',
    'print_run',
    'sudo_print_run',
  ]

def application_exists(ctx, appname):
  folders = [
    "/Applications",
    os.path.expanduser("~/Applications")
  ]
  return any(
      os.path.exists(u"{}/{}.app".format(folder, appname))
      for folder in folders
    )

def brew_install(ctx, names, cask=False, flags=[]):
  if isinstance(names, basestring):
    names = [names]
  installed = brew_installed(ctx, cask=cask)
  names     = [n for n in names if n not in installed]

  if len(names) > 0:
    cmd = [
        'brew',
        'cask' if cask else '',
        'install',
        strjoin(names),
        strjoin(flags),
      ]
    cmd = strjoin(cmd)

    return (0 == (print_run(ctx, cmd)).exited)
  else:
    return False

def brew_installed(ctx, cask=False):
  cmd = ["brew", "cask" if cask else "", "list"]
  result = print_run(ctx, strjoin(cmd), hide="both")
  assert 0 == result.exited
  return result.stdout.strip().split("\n")

def brew_tap(ctx, repo):
  """Add a new repository to Homebrew."""
  if repo not in brew_tapped(ctx):
    print_run(ctx, "brew tap {}".format(repo))

def brew_tapped(ctx):
  """Retrieve list of tapped repositories.

  Returns:
    list of strings, one per repository.
  """
  return print_run(ctx, "brew tap", hide="both").stdout.strip().split("\n")

def command_exists(ctx, cmd, args="--version"):
  try:
    return (0 == print_run(ctx, "{} {}".format(cmd, args), hide="both").exited)
  except invoke.exceptions.Failure:
    return False

def luarocks_install(ctx, name):
  try:
    return (0 == print_run(ctx, 'luarocks install "{}"'.format(name)).exited)
  except invoke.exceptions.Failure:
    return False

def pip_install(ctx, names):
  if isinstance(names, basestring):
    names = [names]
  installed = pip_installed(ctx)
  names     = [n for n in names if n not in installed]
  exit_codes = [
    print_run(ctx, 'pip install "{}"'.format(name)).exited
    for name in names]
  return all(code == 0 for code in exit_codes)

def pip_installed(ctx):
  installed = print_run(ctx, "pip freeze", hide='both').stdout.strip().split("\n")
  return [p.split("==")[0] for p in installed]

def platform():
  return os.uname()[0]

def python_package_exists(ctx, package):
  try:
    return (0 == print_run(ctx, 'python -c "import {}"'.format(package), hide="both"))
  except invoke.exceptions.Failure:
    return False

def print_run(ctx, cmd, *args, **kwargs):
  print OKBLUE + "$ {}".format(cmd) + ENDC
  return ctx.run(cmd, *args, **kwargs)

def sudo_print_run(ctx, cmd, *args, **kwargs):
  print OKRED + "$ sudo {}".format(cmd) + ENDC
  if ctx.config.sudo.password is None:
    ctx.config.sudo.password = getpass.getpass("Sudo password?: ")
  return ctx.sudo(cmd, *args, **kwargs)

def strjoin(strs, joiner=u" "):
  return joiner.join(s for s in strs if s.strip())

def apt_install(ctx, names):
  if isinstance(names, basestring):
    names = [names]

  if len(names) > 0:
    cmd = [
        'apt-get',
        'install',
        '--yes',
        strjoin(names),
      ]
    cmd = strjoin(cmd)

    return (0 == (sudo_print_run(ctx, cmd, hide="out")).exited)
  else:
    return False


@contextlib.contextmanager
def chdir(target_dir):
  original_dir = os.getcwd()
  os.chdir(target_dir)
  yield
  os.chdir(original_dir)
