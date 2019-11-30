source "${HOME}/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Set the LS_COLORS variable
eval $(dircolors --sh)

zstyle :compinstall filename "${HOME}/.zshrc"
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{-}={_}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' original tre
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache true

# zsh history
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=8000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt CORRECT_ALL
setopt DVORAK
setopt EXTENDED_GLOB
setopt HASH_CMDS
setopt LIST_PACKED
setopt MAGIC_EQUAL_SUBST
setopt NOTIFY
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS

bindkey -v
bindkey -M vicmd 't' forward-char
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^N' menu-complete
bindkey -M viins '^P' reverse-menu-complete
bindkey -M viins '^B' push-line

zle -N edit-command-line
bindkey -M vicmd v edit-command-line

autoload -Uz compinit edit-command-line
compinit

autoload -U colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%b %m%u%c'
zstyle ':vcs_info:*' actionformats '%b %m%u%c %a'


precmd() { vcs_info }
PROMPT='%{$fg[cyan]%}%n@%M%{$reset_color%}  %{$fg[blue]%}${PWD/#$HOME/~}%{$reset_color%}  %{$fg[magenta]%}${vcs_info_msg_0_}%{$reset_color%}
%{$fg[red]%}>%{$reset_color%} '

#
# Umask
#

umask u=rwx,g=rx,o=

#
# Env
#

export KEYTIMEOUT=1
export CPUS=$(nproc)

#
# Autojump
#

[[ -s /usr/share/autojump/autojump.zsh ]] && \
  source /usr/share/autojump/autojump.zsh

#
# fzf
#

[ -f "${HOME}/.nix-profile/share/fzf/completion.zsh" ] && \
  source "${HOME}/.nix-profile/share/fzf/key-bindings.zsh"
[ -f "${HOME}/.nix-profile/share/fzf/key-bindings.zsh" ] && \
  source "${HOME}/.nix-profile/share/fzf/completion.zsh"
export FZF_DEFAULT_OPTS='--color=fg+:0,bg+:7,hl:9,hl+:9,info:-1,prompt:-1,marker:-1,pointer:-1,spinner:-1,border:-1,header:-1'
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

function stowswitch() {
  if [[ -d "$1" && -d "$2" ]]; then
    stow -D "$1" && stow "$2"
  else
    echo "wrong directories"
  fi
}

# GHC hacking
function hadrian() {
  if [[ -z "${HADRIAN_FLAVOR}" ]]; then
    echo "Error: set flavor: export HADRIAN_FLAVOR="
  else
    local FLAGS="--flavour=${HADRIAN_FLAVOR} -j $@"
    local COMMAND="$(git rev-parse --show-toplevel)/hadrian/build.sh"
    local FULL="${COMMAND} ${FLAGS}"
    echo ${FULL}
    eval ${FULL}
  fi
}

alias g="git"
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
alias makejj='make -j$((${CPUS} * 2))'
alias makenj='nice make -j$((${CPUS} + 1))'
alias makenjj='nice make -j$((${CPUS} * 2))'
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
alias bcreate="borg create --progress --stats --compression zstd"
alias reboot="sudo /sbin/reboot"
alias poweroff="sudo /sbin/poweroff"
alias shutdown="sudo /sbin/shutdown"

[ -f ~/.zshrc_local ] && source $HOME/.zshrc_local
