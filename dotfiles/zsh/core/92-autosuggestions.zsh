# Initialize syntax highlighting (prerequisite for autosuggestions).
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize autosuggestions.
source ~/.zsh/plugins/zsh-autosuggestions/autosuggestions.zsh

# Register autosuggestions for auto-initialization.
zle-line-init() {
  zle autosuggest-start
}
zle -N zle-line-init
