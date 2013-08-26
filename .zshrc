source ~/.zsh/keys.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/colors.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/edit-command-line.zsh
source ~/.zsh/environment.zsh
source ~/.zsh/history.zsh
source ~/.zsh/options.zsh
source ~/.zsh/prompt.zsh

# app-specific settings
for rc in $(find ~/.zsh/apps/ -iname '*.zsh'); do
  source $rc
done

#
for rc in $(find ~/.zsh/plugins/ -iname '*.zsh'); do
  source $rc
done

# machine-local settings
for rc in $(find ~/.zsh/apps/ -iname '*.zsh'); do
  source $rc
done
