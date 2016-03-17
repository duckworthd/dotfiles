# Initialize autosuggestions.
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Workaround when using the MENU_COMPLETE option. This prevents an issue where
# the suggestion lingers while navigating the completion menu. If MENU_COMPLETE
# is not set, then this will break suggestions.
#
# See https://github.com/zsh-users/zsh-autosuggestions/issues/118 for details.
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+="expand-or-complete"
