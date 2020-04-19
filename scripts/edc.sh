#!/bin/bash

# edc.sh
# 2018 Ian Flournoy

# This file should live at /etc/profile.d/edc.sh

# Layout
#
# 0. Script setup work
# 1. Global features - Beneficial to all users of the system, low impact
# 2. Optional features for for any user
#    - To enable `touch ~/.edc`
# 3. 

CURRENT_USER=$(whoami)
HOME_DIR=$(eval echo ~$CURRENT_USER)

# This script was formerly named ians-profile. We remove it now.
if [ -f /etc/profile.d/ians-profile.sh ]; then
  echo "Old version of script found, replacing with this one"
  sudo rm /etc/profile.d/ians-profile.sh
fi

###
# 1. Global Features
###

# TODO: check for perms
function update_edc() { wget -O /etc/profile.d/edc.sh https://edc.ian.pub/; }

# New aliases and functions don't interrupt existing user workflow
function logdate { date -u '+%Y%m%d_%H%M'; }
function calc() { echo "$1" | bc -l; }

# Better reverse-history visual.  Usage `h wget` shows last 30 times you called wget
function h() { grep "$*" ~/.bash_eternal_history | tail -n 30; }

# Git shortcuts
alias ga="git add"
alias gc="git commit"
alias gl="git log --color --all --decorate --graph --oneline"
alias gp="git pull"
alias gs="git status -sb ."
alias gsa="git status -sb"
alias gd="git diff"
alias gco="git checkout"

# Sysadmin-y quick commands
alias alive="ping -c 3 8.8.8.8"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ..="cd .."


# Useful for ssh'ing to servers that come and go frequently (in an autoscale group). 'e' for ephemeral.
alias sshe="ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -o LogLevel=quiet"
alias scpe="scp -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no"

# AWS's default hostnames are ip-10-0-0-1 so this just ssh's to 10.0.0.1 via sshe
function sshi() { sshe $(echo $1 | tr '-' '.'); }


###
# 2. Optional (higher impact) Features
###

# Bail because the user hasn't enabled optional features
if [ ! -f $HOME_DIR/.edc ]; then
  if [ ! -f $HOME_DIR/.edc-hush ]; then
    echo "/etc/profile.d/edc.sh: You can enable advanced features by touch'ing ~/.edc"
    echo "This file created by /etc/profile.d/edc.sh" > $HOME_DIR/.edc-hush
  fi
  break
fi

# This replaces the cd function with one that ls' a directory after you cd to it
# I find myself doing `cd somedir; ls` too frequently
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

# TODO: Check for no eternal history, and existing .bash_history, concatenate .bash_history into eternal history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
