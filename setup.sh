#!/usr/bin/env sh -xe

# show command, then execute it
function show() {
  echo "$ $@"
  $@
}

# full path to directory containing this file
PROJECT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

echo 'Linking dotfiles to HOME'
# for each dotfile in this directory...
for FNAME in $(find $PROJECT_DIR \
                    -name ".[^.]*" \
                    -maxdepth 1 \
                    \( ! -iname ".git*" -or -iname '.dropbox' \)
              ); do
  OUTPUT=$HOME/$(basename "$FNAME")
  # if $OUTPUT isn't a file or a directory
  if [ ! -f "$OUTPUT" ] && [ ! -d "$OUTPUT" ]; then
    # softlink $FNAME to $OUTPUT
    show ln -s "$FNAME" "$OUTPUT"
  fi
done

# install Homebrew
cd /tmp && ruby -e "$(curl -fsSL "https://raw.github.com/mxcl/homebrew/go")"
brew update

# install XCode
brew install coreutils
open "https://developer.apple.com/downloads/index.action"
echo "Download and install XCode (press ENTER when done)"
read TRASH

# install tmux
brew install tmux
brew install reattach-to-user-namespace

# install wget
brew install wget

# install htop
brew install htop

# install zsh
brew install zsh
chsh -s $(which zsh)

# install MacVim + ctags
brew install macvim --with-lua --override-system-vim
brew install ctags

# install Alfred
cd $HOME/Downloads
wget "http://cachefly.alfredapp.com/Alfred_2.1_218.zip" -O alfred.zip
sudo unzip alfred.zip -d /Applications

# Install Slate
wget "http://www.ninjamonkeysoftware.com/slate/versions/slate-latest.tar.gz" -O slate.tar.gz
sudo tar -xzf slate.tar.gz -C "/Applications"

# Install Chrome
wget "https://dl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg" -O "$HOME/Downloads/chrome.dmg" && open "$HOME/Downloads/chrome.dmg"
echo "Install Chrome (press ENTER to continue)"
read TRASH

# Install KeypassX
# XXX sourceforge doesn't like curl?
wget "http://sourceforge.net/projects/keepassx/files/KeePassX/0.4.3/KeePassX-0.4.3.dmg/download" -O "$HOME/Downloads/keepassx.dmg" && "open $HOME/Downloads/keepassx.dmg"
echo "Install KeypassX (press ENTER to continue)"
read TRASH

# Install Dropbox
wget "https://d1ilhw0800yew8.cloudfront.net/client/Dropbox%202.4.6.dmg" -O "$HOME/Downloads/dropbox.dmg" && open "$HOME/Downloads/dropbox.dmg"
echo "Install Dropbox (press ENTER to continue)"
read TRASH

# Install JVM
wget 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=81813' -O "$HOME/Downloads/jre.dmg" && open "$HOME/Downloads/jre.dmg"
echo "Install Java Runtime Environment (press ENTER to continue)"
read TRASH

# Install MySQL
brew install mysql

# install jq
brew install jq

# install scala
brew install scala

# Install R
brew tap homebrew/science
brew install R

# Install Python + libraries
brew install python gfortran freetype libevent
pip install numpy scipy matplotlib pandas IPython ipdb virtualenv     # scientific
pip install funcy duxlib configurati virtualenv lxml python-dateutil  # productivity
pip install sqlrest gevent MySQL-python bottle pyjade                 # web
pip install nose                                                      # testing
