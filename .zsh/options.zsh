# ===== Basics

# If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt AUTO_CD

# when you cd, put the previous directory on the directory stack. You can use
# `popd` to go up the stack.
setopt AUTO_PUSHD

# Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt PROMPT_SUBST
