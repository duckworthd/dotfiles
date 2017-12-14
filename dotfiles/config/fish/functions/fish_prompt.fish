# Sets left-side terminal prompt. See fish_right_prompt.fish for right-side.
set fish_prompt_pwd_dir_length

function fish_prompt
    # Example:
    #
    #  [12:16:26] user@hostname | ~/Desktop
    #  > ....
    #
    set -l time_text (set_color red)"["(set_color --bold white)(date +"%I:%M:%S")(set_color normal)(set_color red)"]"(set_color normal)
    set -l user_text (set_color brblue)$USER(set_color normal)
    set -l host_text (set_color green)(prompt_hostname)(set_color normal)
    set -l pwd_text (set_color white)(pwd)(set_color normal)
    echo "$time_text $user_text@$host_text | $pwd_text"
    echo "> "
end
