
# This will set "$?" to 1 if eclipse isn't installed, and 0 if it is
if command_exists brew; then
  brew cask list eclipse-ide &> /dev/null

  if [[ $? = 0 ]]; then
    # get root folder of currently linked version of eclipse
    ECLIPSE_ROOT=$(brew cask info eclipse-ide | sed '3q;d' | cut -d' ' -f1)
  
    # add it to PATH (necessary for using eclimd)
    export PATH="$ECLIPSE_ROOT/eclipse:$PATH"
  fi
fi
