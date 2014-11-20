# bind CTRL+P, CTRL+N to search
bindkey "^P"  history-substring-search-up
bindkey "^N"  history-substring-search-down

# bind k and j in vi-mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
