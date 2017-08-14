PLATFORM=$(uname)
if [[ ${PLATFORM} -eq "Linux" ]]; then
  alias volume="amixer -D pulse sset Master"
elif [[ ${PLATFORM} -eq "Darwin" ]]; then
  alias volume="osascript -e 'set Volume'"
fi
