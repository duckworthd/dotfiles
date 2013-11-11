
# Install MySQL
brew install mysql

# start mysql on system boot
ln -sfv /usr/local/opt/mysql/*.plist $HOME/Library/LaunchAgents
launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.mysql.plist
