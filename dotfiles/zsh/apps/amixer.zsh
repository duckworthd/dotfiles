PLATFORM=$(uname)
if [[ ${PLATFORM} -eq "Linux" ]]; then
  alias volume="amixer --device pulse set Master"
elif [[ ${PLATFORM} -eq "Darwin" ]]; then
  alias volume="osascript -e 'set Volume'"
fi
