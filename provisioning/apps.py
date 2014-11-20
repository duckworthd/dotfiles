import os

from invoke import task

from .utils import *


@task("brew_cask")
def alfred():
  if application_exists("Alfred 2"): return
  brew_install("alfred", cask=True)

@task("brew_cask")
def chrome():
  if application_exists("Google Chrome"): return
  brew_install("google-chrome", cask=True)

@task("brew_cask")
def dropbox():
  if application_exists("Dropbox"): return
  brew_install("dropbox", cask=True)

@task("brew_cask")
def evernote():
  if application_exists("Evernote"): return
  brew_install("evernote", cask=True)

@task("brew_cask")
def gitx():
  if application_exists("GitX"): return
  brew_install("gitx", cask=True)

@task("brew_cask")
def java():
  if command_exists("java"): return
  brew_install("java", cask=True)

@task("brew_cask")
def iterm2():
  if application_exists("iTerm"): return
  brew_install("iterm2", cask=True)

@task("brew_cask")
def keepassx():
  brew_tap("caskroom/versions")
  brew_install("keepassx0", cask=True)

@task("homebrew", "xcode", "xcode_license", "ctags")
def macvim():
  if command_exists("mvim"): return
  HOME = os.environ["HOME"]
  brew_install("macvim", flags=["--with-lua", "--override-system-vim"])
  run('mkdir -p {}/.vim/bundle'.format(HOME))
  if not os.path.exists("{}/.vim/bundle/neobundle.vim".format(HOME)):
    run(
        ('git clone "git://github.com/Shougo/neobundle.vim" '
         '"{}/.vim/bundle/neobundle.vim"').format(HOME)
      )
    print "Type ':NeoBundleInstall' the next time you open vim"

@task("brew_cask")
def mjolnir():
  if application_exists("Mjolnir"): return
  brew_install("mjolnir", cask=True)

@task("homebrew", "xquartz")
def R():
  brew_tap("homebrew/science")
  brew_install("R")

@task("homebrew", "dotfiles")
def slate():
  if application_exists("Slate"): return
  brew_install("slate")

@task("brew_cask")
def virtualbox():
  if application_exists('VirtualBox'): return
  brew_install("virtualbox", cask=True)

@task("brew_cask")
def vlc():
  if application_exists("VLC"): return
  brew_install("vlc", cask=True)

@task("brew_cask")
def xquartz():
  if application_exists("Utilities/XQuartz"): return
  brew_install("xquartz", cask=True)
