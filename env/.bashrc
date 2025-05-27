#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# eval "$(starship init bash)"
# starship preset jetpack -o ~/.config/starship.toml

# Display system details
sleep 0.1; fastfetch

# ENVIRONMENT VARIABLES
export PATH="$PATH:$HOME/.local/scripts"
export DEV_ENV=$HOME/personal/dev
export PATH="$PATH:$HOME/go/bin"
