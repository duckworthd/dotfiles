# Sets left-side terminal prompt. See fish_right_prompt.fish for right-side.

# All directories in path except the last are shortened to 1 character.
set fish_prompt_pwd_dir_length 1

function fish_prompt
    # Example:
    #
    #  [12:16:26] user@hostname | ~/Desktop >
    #
    set -l time_text (set_color --bold red)"["(set_color --bold white)(date +"%I:%M:%S")(set_color normal)(set_color --bold red)"]"(set_color normal)
    set -l user_text (set_color --bold brblue)$USER(set_color normal)
    set -l host_text (set_color --bold green)(prompt_hostname)(set_color normal)
    set -l pwd_text (set_color --bold white)(prompt_pwd)(set_color normal)
    set -l prompt_text (set_color --bold cyan)"⟫"(set_color --bold normal)
    echo "$time_text $user_text@$host_text | $pwd_text $prompt_text "
end
