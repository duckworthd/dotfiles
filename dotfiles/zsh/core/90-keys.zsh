# To see the key combo you want to use just do:
# $ cat > /dev/null
# And press it

bindkey -v   # Default to standard emacs bindings, regardless of editor string
bindkey "^K"  kill-whole-line                      # ctrl-k
bindkey "^R"  history-incremental-search-backward  # ctrl-r
bindkey "^A"  beginning-of-line                    # ctrl-a
bindkey "^E"  end-of-line                          # ctrl-e
bindkey "^?"  backward-delete-char                 # fix backspace
bindkey "^W"  backward-kill-word                   # delete previous word

# Prefix search with up and down arrows
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
