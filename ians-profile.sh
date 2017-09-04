#!/bin/bash
# ians-profile.sh

# I typically place this in /etc/profile.d/
# It modifies the behavior of the shell, and starts a new histfile
# both of which disturb other users on the system if used globally

function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}"
    if [ $? -eq 0 ]; then
      /bin/ls -hlp --color=auto --group-directories-first
    fi;
}

function logdate { date '+%Y%m%d_%H%M'; }

function calc() { echo "$1" | bc -l; }

function h() { history | grep "$*" | tail -n 30; }

function update_ians_profile() { wget -O /etc/profile.d/ians-profile.sh https://ian.pub/ians-profile.sh; }

export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
# Flush history when prompt is run
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
