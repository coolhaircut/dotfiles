#!/bin/bash
###############################################################################
#                                                                             #
#               Opinionated, Marginally Dangerous Bash Aliases                #
#                                                                             #
###############################################################################
#                                                                             #
# The $sudo var can be used in aliases that want to automatically sudo.       #
#                                                                             #
# "$sudo" equals 'sudo ' (trailing space) if the following conditions are #
# met; if any of these conditions fail, then "$sudo" equals an empty string.  #
#    (1) If the calling user is not root (redundant), AND                     #
#    (2) If the current directory is not a keybase mount (permissions), AND   #
#    (3) If the current directory is not in '/run/user/####' (permissions).   #
#                                                                             #
###############################################################################
if [ $EUID -eq 0 ] || [[ "$(pwd)" =~ keybase|/run/user/[0-9]+/ ]]; then
    export sudo=''
else
    export sudo='sudo '
fi

###############################################################################
#                                Aliases                                      #
###############################################################################

## Apt package manager run as root
alias apt-get="${sudo}apt-get"
alias apt-key="${sudo}apt-key"
alias apt="${sudo}apt"
alias pip="python3 -m pip"
alias snap="${sudo}snap"
alias update-initramfs="${sudo}update-initramfs -uv"
alias update-grub="${sudo}update-grub"

## Composite Apt/pip upgrades
alias update-all="apt update && apt full-upgrade -y && apt autoremove --purge -y; command -v pip3 && pip3 install --upgrade pip; command -v snap && snap refresh; update-initramfs"

## Change perms/owner as root
alias chmod="${sudo}chmod -vf"
alias chmodr="chmod -R"
alias chmodx="chmod +x"
alias chown="${sudo}chown -vf"
alias chownr="chown -R"

## Copy/Move/Remove
alias cp="cp -vfp"
alias cpr="cp -R"
alias mv="mv -vf"
alias rm="rm -f"
alias rmr="rm -R"

## Disk queries
alias blkid="blkid -o list"
alias btrfs="${sudo}btrfs"
alias df="${sudo}df -h"
alias dfa="df | grep -Ev '(loop|tmpfs|udev)'"
alias disk-uuid="blkid -o value -s UUID"
alias diskuuid="disk-uuid"
alias du="${sudo}du -sh"
alias free="free -ht"
alias iotop='${sudo}iotop -Poa'
alias lsblk="${sudo} lsblk -o NAME,MAJ:MIN,RM,SIZE,TYPE,FSTYPE,LABEL,MOUNTPOINT -e 7"

## Misc
alias entropy="cat /proc/sys/kernel/random/entropy_avail"
alias ffprobe='ffprobe -hide_banner -loglevel 32'
alias ffmeta='ffmeta -hide_banner -loglevel 32 -filter_threads $(nproc)'
alias graph='git log --all --decorate --oneline --graph'
alias jp2a='jp2a --colors --color-depth=8 --term-fit --background=dark'
alias kb="keybase"
alias mkpasswd='/usr/bin/mkpasswd.pl -n -l 16'
alias mkuuid='/usr/bin/uuid -m -v4'
alias shutdown="${sudo}shutdown"
alias youtube-dl='youtube-dl --no-call-home --verbose --prefer-ffmpeg --add-metadata -i --continue'

## IP addr/link/netfilter as root
alias ip="${sudo}ip"
alias ip6="ip -6"
alias iptables="${sudo}iptables"
alias ip6tables="${sudo}ip6tables"
alias iptables-save="${sudo}iptables-save"
alias ip6tables-save="${sudo}ip6tables-save"
alias iptables-restore="${sudo}iptables-restore"
alias ip6tables-restore="${sudo}ip6tables-restore"
alias iptables-apply="${sudo}iptables-restore"
alias ip6tables-apply="${sudo}ip6tables-restore"

## Process misc
alias killall="${sudo}killall"
alias top="${sudo}top -o '%CPU'"

## List files
alias ls="ls --color=auto"
alias ll="ls -lAFh"
alias la="ls -A"
alias l="la"
alias ls="ls -AC --color=auto"

## Netplan.io as root
alias netplan="${sudo}netplan"

## Netstat (all/listening)
alias netstat="${sudo}netstat -pntu46W"
alias netstata="netstat -a"
alias netstatl="netstat -l"

## Systemd shortcuts
function scbanish {
    sudo systemctl stop "$1";
    sudo systemctl stop "${1}.socket";
    sudo systemctl disable "$1";
    sudo killall "$1";
}
alias scb='scbanish'
alias sc="${sudo}systemctl"
alias scdown="sc stop"
alias scup="sc start"
alias scdr="sc daemon-reload"
alias scd="sc disable"
alias sce="sc enable"
alias scm="sc mask"
alias scr="sc restart"
alias scstop="sc stop"
alias scstat="sc status -l"
alias scstart="sc start"
alias scu="sc unmask"

## Mkdir and CD
function mkcd { mkdir "$1"; cd "$1"; }
alias mkdircd="mkcd"
alias cdmkdir="mkcd"
alias cdmk="mkcd"
alias warp='cd "$(realpath .)"'
alias g='goto'

## Colors
export RESET=NOCOLOR='\033[0m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export ORANGE='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHTGRAY='\033[0;37m'
export DARKGRAY='\033[1;30m'
export LIGHTRED='\033[1;31m'
export LIGHTGREEN='\033[1;32m'
export YELLOW='\033[1;33m'
export LIGHTBLUE='\033[1;34m'
export LIGHTPURPLE='\033[1;35m'
export LIGHTCYAN='\033[1;36m'
export WHITE='\033[1;37m'

## Typos
alias audo='sudo'
alias suso='sudo'
alias namo='nano'
