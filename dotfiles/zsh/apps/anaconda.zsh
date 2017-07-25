if [[ -e "${HOME}/anaconda2" ]]; then
  # Set PYTHONPATH to Anaconda's home directory if it exists.
  PYTHONPATH="${HOME}/anaconda2"

  # Give Anaconda's version of python precedence over system python.
  PATH="${HOME}/anaconda2/bin:${PATH}"
fi
