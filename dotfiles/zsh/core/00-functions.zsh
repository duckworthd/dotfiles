function command_exists() {
  hash "$1" &> /dev/null;
}

function variable_exists() {
  test -z "$1"
}
