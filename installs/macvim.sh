
# install MacVim + ctags
brew install macvim --with-lua --override-system-vim
brew install ctags

# .vim/bundle isn't tracked by git. install NeoBundle so that the next time vim
# opens, it'll install all its packages.
if [ ! -e "$HOME/.vim/bundle/neobundle.vim" ]; then
  mkdir -p "$HOME/.vim/bundle"
  git clone "git://github.com/Shougo/neobundle.vim" "$HOME/.vim/bundle/neobundle.vim"
  echo "Type ':NeoBundleInstall' the next time you open vim"
fi

