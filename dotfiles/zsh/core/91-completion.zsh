autoload -U compinit && compinit

# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD

# When completing from the middle of a word, move the cursor to the end of the word
setopt ALWAYS_TO_END

# show completion menu on successive tab presses
setopt AUTO_MENU

# Press <TAB> twice to see a menu of options to autocomplete
zstyle ':completion:*:*:*:*:*' menu select

# Cache completions for very slow commands
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path /tmp/zsh-cache

# Force prefix matching for completion. Makes completion MUCH faster.
zstyle ':completion:*' accept-exact '*(N)'

# Colored completion for filenames. Requires LS_COLORS already be defined.
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
  echo "LS_COLORS not set. Cannot enable colors for ZSH completion either."
fi
