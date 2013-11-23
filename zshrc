if [[ -f $HOME/.profile ]] ; then
  source $HOME/.profile
fi

# Set the LS_COLORS variable
eval $(dircolors --sh)

# Customize to your needs...
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{-}={_}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' original tre
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache 1

zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit colors vcs_info
colors
compinit

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats "$fg[green]%s %b $fg[red]%a %u %c$reset_color"
zstyle ':vcs_info:*' formats "$fg[green]%s %b $fg[red]%u %c$reset_color"
zstyle ':vcs_info:*' stagedstr 's'
zstyle ':vcs_info:*' unstagedstr 'u'

HISTFILE=$HOME/.histfile
HISTSIZE=16384
SAVEHIST=8192

setopt appendhistory
setopt autocd
setopt autopushd
setopt correct
setopt dvorak
setopt extendedglob
setopt histexpiredupsfirst
setopt histignorealldups
setopt histignoredups
setopt listpacked
setopt notify
setopt prompt_subst
setopt pushdignoredups

bindkey -v
bindkey -M vicmd 't' forward-char
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^N' menu-complete
bindkey -M viins '^P' reverse-menu-complete
bindkey -M viins '^B' push-line

precmd () {
  vcs_info
}

ULCORNER="┌"
LLCORNER="└"
HBAR="─"
PROMPT='%{$fg[red]%}${ULCORNER}%{$reset_color%} %{$fg[yellow]%}%m %{$fg[cyan]%}%48<..<%~%<<%(1j.  %j  .  )%{$reset_color%}${vcs_info_msg_0_}
%{$fg[red]%}${LLCORNER}%{$reset_color%} '

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

export EDITOR=vim
export VIMHOME="${HOME}/.vim"
export GREP_OPTIONS="--color"

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
# Autojump
#

[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh

#
# Functions and aliases
#

function mkcd() {
  mkdir -p "$1" && cd "$1"
}

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
alias gvimr="gvim --remote"
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
alias tmux3="tmux new -s3"
alias tmux4="tmux new -s4"
alias gvim1="gvim --servername 1"
alias gvim2="gvim --servername 2"
alias gvim3="gvim --servername 3"
alias bell="echo -e \"\a\""
alias reboot="sudo /sbin/reboot"
alias poweroff="sudo /sbin/poweroff"
alias shutdown="sudo /sbin/shutdown"

if [[ -f $HOME/.profile ]] ; then
  source $HOME/.zshrc_local
fi
