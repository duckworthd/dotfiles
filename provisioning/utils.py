import os

import invoke
from invoke import task

__all__ = [
    'application_exists',
    'brew_install',
    'brew_tap',
    'command_exists',
    'pip_install',
    'python_package_exists',
    'run',
  ]

def application_exists(appname):
  folders = [
    "/Applications",
    os.path.expanduser("~/Applications")
  ]
  return any(
      os.path.exists(u"{}/{}.app".format(folder, appname))
      for folder in folders
    )

def brew_install(names, cask=False, flags=[]):
  if isinstance(names, basestring):
    names = [names]
  installed = brew_installed(cask=cask)
  names     = [n for n in names if n not in installed]

  if len(names) > 0:
    cmd = [
        'brew',
        'cask' if cask else '',
        'install',
        u" ".join(names),
        u" ".join(flags),
      ]
    run(u" ".join(cmd))
    return True
  else:
    return False

def brew_installed(cask=False):
  cmd = "brew {} list".format("cask" if cask else "")
  return run(cmd, hide="both").stdout.strip().split("\n")

def brew_tap(repo):
  if repo not in brew_tapped():
    run("brew tap {}".format(repo))

def brew_tapped():
  return run("brew tap", hide="both").stdout.strip().split("\n")

def command_exists(cmd, args="--version"):
  try:
    run("{} {}".format(cmd, args), hide="both")
    return True
  except invoke.exceptions.Failure:
    return False

def pip_install(names):
  if isinstance(names, basestring):
    names = [names]
  installed = pip_installed()
  names     = [n for n in names if n not in installed]
  for name in names:
    run('pip install "{}"'.format(name))
  return len(names) > 0

def pip_installed():
  installed = run("pip freeze", hide='both').stdout.strip().split("\n")
  return [p.split("==")[0] for p in installed]

def platform():
  return os.uname()[0]

def python_package_exists(package):
  try:
    run('python -c "import {}"'.format(package), hide="both")
    return True
  except invoke.exceptions.Failure:
    return False

def run(*args, **kwargs):
  if 'hide' not in kwargs:
    print "$ {}".format(args[0])
  return invoke.run(*args, **kwargs)
