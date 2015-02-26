############################# LEFT SIDE ########################################
PS1=""

# the time
PS1+="[${PR_WHITE}%D{%H:%M:%S}${RESET}]"
PS1+=" "

# username @ computer_name
PS1+="${PR_BLUE}${USERNAME}${RESET}"
PS1+="@"
PS1+="${PR_GREEN}%m${RESET}"

# current directory
PS1+=":"
PS1+="${PR_WHITE}%5(c:.../:)%4c${RESET}"

# new line
PS1+="
> "

############################# RIGHT SIDE #######################################
export PS1

RPS1=""

# The right side of the prompt indicates if we're in INSERT or NORMAL vi-mode
function zle-line-init zle-keymap-select {
  VIM_NORMAL_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
  VIM_INSERT_PROMPT=""

  # ${VARIABLE/PATTERN/REPALCEMENT} == If VARIABLE matches PATTERN, then insert
  # REPLACEMENT here; otherwise, insert VARIABLE's value.
  RPS1="${${KEYMAP/vicmd/$VIM_NORMAL_PROMPT}/(main|viins)/$VIM_INSERT_PROMPT}"
  zle reset-prompt
}

# Register callback on line initialization and keymap selection (aka vim mode
# switch).
zle -N zle-line-init
zle -N zle-keymap-select
