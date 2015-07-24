# Here's an overview of how completion works,
#
# 0. Type "elm -A <TAB>".
# 1. The shell starts and somewhere in your `.zshrc' file you are calling
#   "autoload -Uz compinit; compinit". Now, compsys is online.
# 2. While compinit is running it will find the `_elm' file in one directory of
#   `$fpath'. This happens at the call site of "compinit".
# 3. Compinit will read the first like of that file, find out that it's a
#   completion for a command called "elm" and make a note of that in a mapping
#   for later.
# 4. Then compinit will call `autoload' for the "_elm" file, so its code is
#   loaded from the file when it is referenced for the first time.
# 5. At the prompt, you typed "elm -A " and pressed the tab key, which will set
#   the completion system in motion.
# 6. Compsys recognises, that for the current cursor position the word in
#   command position is "elm".
# 7. It'll look up which completion function is in charge for that command in
#   the mapping it made during startup. It'll find that that's "_elm".
# 8. That function gets called and (when it is run for the first time) zsh
#   automatically loads its code from the "_elm" file in `$fpath'.
# 9. The `_arguments' function analyses the situation and figures out, that it
#   needs to handle an argument to the "-A" option of the command, which it
#   delegates to the `_files' function - as specified in the option's optspec.

# Allow completion from within a word/phrase. For example, if I type "Mafile",
# the move the cursor over "f" and hit tab, zsh will complete to "Makefile"
# instead of searching for files prefixed with "Mafile".
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

# Initialize tab completion engine.
autoload -U compinit && compinit
