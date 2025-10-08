import contextlib
import getpass
import os

import invoke

from provisioning import colors


def is_apt_installed(c, package):
  result = print_run(c, f'dpkg -l "{package}"', hide="both")
  return (0 == result.return_code)


def command_exists(c, cmd, args="--version"):
  try:
    result = print_run(c, f"{cmd} {args}", hide="both")
    return (0 == result.return_code)
  except invoke.exceptions.Failure:
    return False


def pip_install(c, names, sudo=False):
  if isinstance(names, str):
    names = [names]
  installed = pip_installed(c)
  names = [n for n in names if n not in installed]

  runner = print_run
  if sudo:
    runner = sudo_print_run

  exit_codes = [
      runner(c, f'python3 -m pip install "{name}"').return_code
      for name in names]
  return all(code == 0 for code in exit_codes)


def pipx_inject(c, names):
  if isinstance(names, str):
    names = [names]

  exit_codes = [
      print_run(c, f'pipx inject "invoke" "{name}"').return_code
      for name in names
  ]
  return all(code == 0 for code in exit_codes)


def pip_installed(c):
  installed = print_run(c, "python3 -m pip freeze", hide='both').stdout.strip().split("\n")
  return [p.split("==")[0] for p in installed]


def platform():
  return os.uname()[0]


def is_pip_installed(c, package):
  try:
    result = print_run(c, f'python3 -c "import {package}"', hide="both")
    return 0 == result.return_code
  except invoke.exceptions.Failure:
    return False


def print_run(c, cmd, *args, **kwargs):
  print(colors.OKBLUE + "$ {}".format(cmd) + colors.ENDC)
  return c.run(cmd, *args, **kwargs, warn=True)


def sudo_print_run(c, cmd, *args, **kwargs):
  print(colors.OKGREEN + f"$ sudo {cmd}" + colors.ENDC)
  if c.config.sudo.password is None:
    c.config.sudo.password = getpass.getpass("Sudo password?: ")
  return c.sudo(cmd, *args, **kwargs)


def strjoin(strs, joiner=u" "):
  return joiner.join(s for s in strs if s.strip())


def apt_install(c, names):
  if isinstance(names, str):
    names = [names]

  if len(names) > 0:
    cmd = [
        'apt-get',
        'install',
        '--yes',
        strjoin(names),
    ]
    cmd = strjoin(cmd)

    return (0 == (sudo_print_run(c, cmd, hide="out")).exited)
  else:
    return False


@contextlib.contextmanager
def chdir(target_dir):
  original_dir = os.getcwd()
  os.chdir(target_dir)
  yield
  os.chdir(original_dir)


def is_brew_installed(c, package):
  try:
    result = print_run(c, f'brew list {package}', hide="both")
    return 0 == result.return_code
  except invoke.exceptions.Failure:
    return False


def brew_install(c, names):
  if isinstance(names, str):
    names = [names]

  if len(names) > 0:
    cmd = [
        'brew',
        'install',
        strjoin(names),
    ]
    cmd = strjoin(cmd)

    return (0 == (print_run(c, cmd, hide="out")).exited)
  else:
    return False
