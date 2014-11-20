# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey -v   # Default to standard emacs bindings, regardless of editor string
bindkey "^K"  kill-whole-line                      # ctrl-k
bindkey "^R"  history-incremental-search-backward  # ctrl-r
bindkey "^A"  beginning-of-line                    # ctrl-a
bindkey "^E"  end-of-line                          # ctrl-e
bindkey "^?"  backward-delete-char                 # fix backspace
bindkey "^W"  backward-kill-word                   # delete previous word
