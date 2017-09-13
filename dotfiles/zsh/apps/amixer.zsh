PLATFORM=$(uname)
if [[ ${PLATFORM} -eq "Linux" ]]; then
  alias get-volume="amixer -D pulse get Master"
  alias set-volume="amixer -D pulse sset Master"
elif [[ ${PLATFORM} -eq "Darwin" ]]; then
  alias set-volume="osascript -e 'set Volume'"
fi
