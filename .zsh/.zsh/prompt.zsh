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
PS1+="${PR_WHITE}%~${RESET}"

# new line
PS1+="
> "
