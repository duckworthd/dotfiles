import os

import invoke
from invoke import task


### UTILITIES ###

def run(*args, **kwargs):
  if 'hide' not in kwargs:
    print "$ {}".format(args[0])
  return invoke.run(*args, **kwargs)

def download(url, save_to="{}/Downloads".format(os.environ["HOME"]), filename=None):
  """Download a file to disk"""
  filename = filename or os.path.split(url)[1]
  path     = os.path.join(save_to, filename)
  try:
    run('wget --progress=bar "{}" -O "{}"'.format(url, path))
    return path
  except Exception as e:
    raise Exception("Unable to fetch {}".format(url))

def open(path, appname):
  """Open a file using the `open` command"""
  run('open "{}"'.format(path))
  print (
    "Install {} (press ENTER to continue)".format(appname)
  )
  raw_input()

def brew_tap(repo):
  tapped = run("brew tap", hide="both").stdout.strip().split("\n")
  if repo not in tapped:
    run("brew tap {}".format(repo))

def brew_install(names, check=None):
  if isinstance(names, basestring):
    names = [names]

  names_ = []
  for name in names:
    if check is None:
      # assume this package installs a command, and moreover that the command's
      # name is the package name. Check if the command can be executed.
      if command_exists(name): pass
      else                   : names_.append(name)
    else:
      # use a custom function to check if command exists
      if check(): pass
      else      : names_.append(name)

  names = names_
  if len(names) > 0:
    run("brew install {}".format(" ".join(names)))
    return True
  else:
    return False

def pip_install(names, check=None):
  if isinstance(names, basestring):
    names = [names]

  names_ = []
  for name in names:
    if check is None:
      check_ = lambda: python_package_exists(name)
    else:
      check_ = check

    if check_(): pass
    else       : run('pip install "{}"'.format(name))

  return len(names_) > 0

def unzip(path):
  run('sudo unzip "{}" -d /Applications'.format(path))

def untar(path, compressed=True):
  if compressed:
    compress_flag = "z"
  else:
    compress_flag = ""

  run('sudo tar -x{}f "{}" -C "/Applications"'.format(compress_flag, path))

def command_exists(cmd, args="--version"):
  try:
    run("{} {}".format(cmd, args), hide="both")
    return True
  except invoke.exceptions.Failure:
    return False

def python_package_exists(package):
  try:
    run('python -c "import {}"'.format(package), hide="both")
    return True
  except invoke.exceptions.Failure:
    return False


### TASKS ###

@task
def homebrew():
  if not command_exists("brew"):
    run('ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"')
    run("brew update")

@task("homebrew")
def ack():
  brew_install("ack")

@task("wget")
def alfred():
  if os.path.exists("/Applications/Alfred 2.app"):
    return
  unzip(download("http://cachefly.alfredapp.com/Alfred_2.2_243b.zip"))

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

@task("wget")
def chrome():
  if os.path.exists("/Applications/Google Chrome.app"):
    return
  open(download("https://dl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg"), "Chrome")

@task("wget")
def dropbox():
  if os.path.exists("/Applications/Dropbox.app"):
    return
  open(download("https://d1ilhw0800yew8.cloudfront.net/client/Dropbox%202.4.6.dmg"), "Dropbox")

@task("wget")
def evernote():
  if os.path.exists("/Applications/Evernote.app"):
    return
  open(download("https://evernote.com/download/get.php?file=EvernoteMac", filename="Evernote.dmg"), "Evernote")

@task("wget")
def gitx():
  if os.path.exists("/Applications/GitX.app"):
    return
  open(download("http://builds.phere.net/GitX/development/GitX-dev.dmg"), "GitX")

@task("wget")
def hipchat():
  if os.path.exists("/Applications/HipChat.app"):
    return
  open(download("https://hipchat.com/downloads/latest/mac"), "HipChat")

@task("homebrew")
def htop():
  brew_install("htop")

@task("python")
def httpie():
  if command_exists("http"):
    return
  pip_install("httpie")

@task("wget")
def java():
  if os.path.exists("/System/Library/Frameworks/JavaVM.framework/Home"):
    return
  open(download("http://javadl.sun.com/webapps/download/AutoDL?BundleId=81813"), "Java Runtime")

@task("homebrew")
def jq():
  brew_install("jq")

@task("wget")
def keepassx():
  if os.path.exists("/Applications/KeePassX.app"):
    return
  open(download("http://sourceforge.net/projects/keepassx/files/KeePassX/0.4.3/KeePassX-0.4.3.dmg/download"), "KeePassX")

@task("homebrew")
def macvim():
  if command_exists("mvim"):
    return
  HOME = os.environ["HOME"]
  brew_install("macvim", lambda: command_exists("mvim"))
  brew_install("ctags")
  run('mkdir -p {}/.vim/bundle'.format(HOME))
  run('git clone "git://github.com/Shougo/neobundle.vim" "{}/.vim/bundle/neobundle.vim"'.format(HOME))
  print "Type ':NeoBundleInstall' the next time you open vim"

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
  if os.path.exists("$(brew --prefix)/bin/python"):
    return
  brew_install("python")

@task("python")
def python_scientific():
  # scipy
  brew_install("gfortran")

  # matplotlib
  brew_install("freetype", lambda: os.path.exists("/usr/local/Cellar/freetype"))
  pip_install("pyparsing")

  # `pip install scipy` doesn't work with Homebrew due to path issues, so let
  # homebrew handle its installation instead.
  brew_tap("samueljohn/python")
  brew_install("numpy"     ,lambda: python_package_exists("numpy"     ))
  brew_install("scipy"     ,lambda: python_package_exists("scipy"     ))
  brew_install("matplotlib",lambda: python_package_exists("matplotlib"))

  pip_install([
    "pandas",
    "IPython",
    "ipdb",
  ])

@task("python")
def python_productivity():
  brew_install("libevent", lambda: os.path.exists("/usr/local/Cellar/libevent"))
  brew_install( "libyaml", lambda: os.path.exists( "/usr/local/Cellar/libyaml"))
  brew_install( "libxml2", lambda: os.path.exists( "/usr/local/Cellar/libxml2"))
  pip_install(         "PyYAML", lambda: python_package_exists("yaml"))
  pip_install("python-dateutil", lambda: python_package_exists("dateutil"))
  pip_install([
    "configurati",
    "dataset",
    "duxlib",
    "funcy",
    "gevent",
    "invoke",
    "lxml",
    "virtualenv",
  ])

@task("python", "mysql")
def python_web():
  pip_install("MySQL-python", lambda: python_package_exists("MySQLdb"))
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
  pip_install("gsutil", lambda: command_exists("gsutil"))

@task("homebrew")
def coreutils():
  brew_install("coreutils", lambda: command_exists("gdircolors"))

@task("homebrew", "xquartz")
def R():
  brew_tap("homebrew/science")
  brew_install("R", lambda: command_exists("R"))

@task("homebrew")
def s3cmd():
  brew_install("s3cmd")

@task("homebrew")
def scala():
  brew_install("scala", lambda: os.path.exists( "/usr/local/Cellar/scala"))

@task("homebrew", "dotfiles")
def slate():
  if os.path.exists("/Applications/Slate.app"):
    return
  untar(download("http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz"))
  run("open /Applications/Slate.app")

@task("homebrew", "dotfiles")
def tmux():
  brew_install("tmux", lambda: command_exists("tmux", "-V"))
  brew_install("reattach-to-user-namespace")

@task("homebrew")
def tree():
  brew_install("tree")

@task("homebrew")
def tunnelblick():
  if os.path.exists("/Applications/Tunnelblick.app"):
    return
  open(download("https://sourceforge.net/projects/tunnelblick/files/All%20files/Tunnelblick_3.3.dmg/download"), "Tunnelblick")

def xcode():
  if command_exists("gcc"):
    return
  run('open "https://developer.apple.com/downloads/index.action"')
  print (
    "Download and install XCode and Command Line Tools (press ENTER when done)"
  )

@task("homebrew", "dotfiles")
def zsh():
  if os.path.exists("/usr/local/bin/zsh"):
    return
  brew_install("zsh")
  run('chsh -s $(which zsh)')

@task
def dotfiles():
  """symlink dotfiles to $HOME"""
  PROJECT_ROOT = os.path.split(__file__)[0]
  HOME         = os.environ["HOME"]
  sources = (
    run(
      'find "{}" -name ".[^.]*" -maxdepth 1'.format(PROJECT_ROOT),
      hide='out'
    )
    .stdout
    .strip()
    .split("\n")
  )

  for source in sources:
    if source.endswith(".dropbox"):
      continue
    if ".git" in source:
      continue

    target = os.path.join(HOME, os.path.split(source)[1])
    if not os.path.exists(target):
      run('ln -s "{}" "{}"'.format(source, target))

@task
def xquartz():
  if os.path.exists("/Applications/Utilities/XQuartz.app"):
    return
  open(download("http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.5.dmg", "XQuartz"))


### AGGREGATE TASKS ###

@task
def common():
  homebrew()
  ack()
  alfred()
  autojump()
  wget()
  chrome()
  dropbox()
  evernote()
  gitx()
  htop()
  httpie()
  java()
  jq()
  keepassx()
  macvim()
  parallel()
  python()
  python_scientific()
  python_productivity()
  coreutils()
  scala()
  slate()
  tmux()
  tree()
  xcode()
  zsh()
  dotfiles()

@task
def home():
  common()

@task
def work():
  common()
  hipchat()
  mysql()
  python_web()
  python_amazon()
  R()
  s3cmd()
  tunnelblick()
