if [[ $- != *i* ]] ; then
	# Shell is non-interactive. Bye, bye..
	return
fi


#
# Bash settings
#

set -o notify
set -o vi

shopt -s cdspell
shopt -s cdable_vars
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s checkwinsize


#
# Color definitions.
#

# Foreground
fgk='\[\e[0;30m\]'
fgr='\[\e[0;31m\]'
fgg='\[\e[0;32m\]'
fgy='\[\e[0;33m\]'
fgb='\[\e[0;34m\]'
fgm='\[\e[0;35m\]'
fgc='\[\e[0;36m\]'
fgw='\[\e[0;37m\]'

# Background
bgk='\[\e[40m\]'
bgr='\[\e[41m\]'
bgg='\[\e[42m\]'
bgy='\[\e[43m\]'
bgb='\[\e[44m\]'
bgm='\[\e[45m\]'
bgc='\[\e[46m\]'
bgw='\[\e[47m\]'

# Bold
boldk='\[\e[1;30m\]'
boldr='\[\e[1;31m\]'
boldg='\[\e[1;32m\]'
boldy='\[\e[1;33m\]'
boldb='\[\e[1;34m\]'
boldm='\[\e[1;35m\]'
boldc='\[\e[1;36m\]'
boldw='\[\e[1;37m\]'

#Underline
unkk='\[\e[4;30m\]'
undr='\[\e[4;31m\]'
undg='\[\e[4;32m\]'
undy='\[\e[4;33m\]'
undb='\[\e[4;34m\]'
undm='\[\e[4;35m\]'
undc='\[\e[4;36m\]'
undw='\[\e[4;37m\]'

# Reset
fgrst='\[\e[00m\]'


#
# Prompt
#

export PROMPT_COMMAND=create_prompt

function create_prompt() {
  case $TERM in
    xterm*|rxvt*|screen*)
    local TITLEBAR="\[\033]0;${PWD}\007\]"
    ;;
    *)
    local TITLEBAR=""
    ;;
  esac
  if [ "$PWD" = "$HOME" ]
  then
    PSDIR="${fgr}~"
  elif [ "$PWD" = "/" ]
  then
    PSDIR="${fgr}${PWD}"
  else
    DIR=${PWD##/*/}
    DIR=${DIR/\//}
    REST=${PWD%/*}
    REST=${REST/#"$HOME"/"~"}
    if [[ ${#REST} -gt 10 ]]; then
      REST="..${REST:$((${#REST} - 10))}"
    fi
    PSDIR="${fgb}${REST}/${fgr}${DIR}"
  fi
  PS1="${PSDIR} ${fgg}\j${fgrst} > "
  if [ -z "${SCRATCHPAD}" ]
  then
    PS1="${TITLEBAR}${PS1}"
  fi
}


#
# Umask
#
umask u=rwx,g=rx,o=


#
# Exports
#

export LANG=en_US.UTF8

if [ "$TERM" = "xterm" ]
then
  export TERM=xterm-256color
fi

export HISTCONTROL=ignoreboth
export HISTFILESIZE=16384

export EDITOR=/usr/bin/vim
export VIMHOME="${HOME}/.vim"
export CCACHE_DIR="/home/m/.ccache"
export EJECT=/dev/sr0
export GREP_OPTIONS="--color"

export APPAREO_OPTIONS="--master-repository-name gentoo \
--extra-repository-dir /usr/portage/"

# PATH for local bin directory.
if [ -z "$(echo ${PATH} | grep ${HOME}/local/bin)" ] ; then
	export PATH="${HOME}/local/bin:${PATH}"
	export MANPATH="${HOME}/local/man:${MANPATH}"
fi

# PATH for binaries installed by cabal.
if [ -z "$(echo ${PATH} | grep ${HOME}/.cabal/bin)" ] ; then
	export PATH="${HOME}/.cabal/bin:${PATH}"
fi


#
# Functions and aliases
#

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias ".."="cd .."
alias pd="pushd"
alias pp="pushp"
alias ls="ls --color=auto -F --group-directories-first \
--dereference-command-line-symlink-to-dir"
alias sl="ls"
alias l="ls"
alias lx="ls -X"
alias ll="ls -lh"
alias llx="ll -X"
alias lo="ls -oh"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias cpath="echo \$PWD | xsel -b"
alias vpath='cd "$(xsel -b)"'
alias cal="cal -m"
alias free="free -m"
alias low="nice ionice -c 3"
alias du="du -h"
alias df="df -h"
alias di="di -h"
alias vi="vim"
alias bc="bc -q"
alias xsel="xsel -b"
alias mps="ps -o pid,state,ruser,time,rss,command"
alias tmuxm="tmux new -sm"
alias tmuxi="tmux new -si"
alias tmuxj="tmux new -sj"
alias tmuxs="tmux new -ss"
alias tmux0="tmux new -s0"
alias tmux1="tmux new -s1"
alias tmux2="tmux new -s2"
alias bell="echo -e \"\a\""
alias reboot="sudo /sbin/reboot"
alias poweroff="sudo /sbin/poweroff"
alias shutdown="sudo /sbin/shutdown"
