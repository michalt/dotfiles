if [[ -f "${HOME}/.profile" ]] ; then
  source "${HOME}/.profile"
fi

export PER_DIRECTORY_HISTORY_TOGGLE='^Y'

if [[ -f "${HOME}/soft/antigen/antigen.zsh" ]] ; then
  source "${HOME}/soft/antigen/antigen.zsh"
fi

antigen use oh-my-zsh

antigen bundle git
antigen bundle per-directory-history
antigen bundle vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme pure

antigen apply

# Set the LS_COLORS variable
eval $(dircolors --sh)

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{-}={_}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' original tre
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache true

zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit edit-command-line
compinit

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
setopt magic_equal_subst

bindkey -v
bindkey -M vicmd 't' forward-char
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^N' menu-complete
bindkey -M viins '^P' reverse-menu-complete
bindkey -M viins '^B' push-line

zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#
# Umask
#

umask u=rwx,g=rx,o=

#
# Env
#

export CPUS=$(nproc)

#
# Autojump
#

[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh

#
# fzf
#

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--color=fg+:0,bg+:7,hl:9,hl+:9,info:8,prompt:8,marker:8,pointer:8,spinner:8'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#
# Nix
#

[[ -s $HOME/.nix-profile/etc/profile.d/nix.sh ]] && source $HOME/.nix-profile/etc/profile.d/nix.sh

#
# Functions and aliases
#

function mkcd() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
  cd "$1"
}

function sswitch() {
  if [[ -d "$1" && -d "$2" ]]; then
    stow -D "$1" && stow "$2"
  else
    echo "wrong directories"
  fi
}

function nix-zsh() {
  if [[ -z "$1" ]]; then
    echo "Usage: nix-zsh <env>"
  elif [[ ! -z "$WITHIN_NIX" ]]; then
    echo "Nested nix-shells are not supported"
  else
    WITHIN_NIX="n:$1  " \
      nix-shell --command ${SHELL} -A $1 ${HOME}/default.nix $@[2,-1]
  fi
}

function nix-zsh2() {
  local NIX_PROFILE_PATH="$HOME/.nix-profiles/$1"
  if [[ -z "$1" ]]; then
    echo "Usage: nix-source <env>"
  elif [[ ! -z "$WITHIN_NIX" ]]; then
    echo "Nested nix-shells are not supported"
  elif [[ ! -d "$NIX_PROFILE_PATH" ]]; then
    echo "No directory $NIX_PROFILE_PATH"
  else
    PATH="$NIX_PROFILE_PATH/bin:$PATH" \
    LIBRARY_PATH="$NIX_PROFILE_PATH/lib:$LIBRARY_PATH" \
    C_INCLUDE_PATH="$NIX_PROFILE_PATH/include:$C_INCLUDE_PATH" \
    WITHIN_NIX="n:$1  " \
      $SHELL
  fi
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
alias cp="cp --reflink=auto -i"
alias mv="mv -i"
alias cpath="echo \$PWD | xsel -b"
alias vpath='cd "$(xsel -b)"'
alias cal="cal -m"
alias free="free -m"
alias low="nice ionice -c 3"
alias du="du -h"
alias df="df -h"
alias di="di -h"
alias vi="nvim"
alias bc="bc -q"
alias xsel="xsel -b"
alias makej='make -j$((${CPUS} + 1))'
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
alias bell="echo -e \"\a\""
alias reboot="sudo /sbin/reboot"
alias poweroff="sudo /sbin/poweroff"
alias shutdown="sudo /sbin/shutdown"

[ -f ~/.zshrc_local ] && source $HOME/.zshrc_local
