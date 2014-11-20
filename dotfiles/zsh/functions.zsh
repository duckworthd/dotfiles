function command_exists() {
  hash "$1" &> /dev/null;
}
