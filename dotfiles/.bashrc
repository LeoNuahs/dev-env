#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Environment variables
export HYPRSHOT_DIR="$HOME/Pictures/Screenshots"
export XDG_PICTURES_DIR="$HOME/Pictures"
export SUDO_EDITOR="/usr/bin/nvim"

fastfetch
