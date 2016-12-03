export HISTFILE=~/.histfile
export HISTSIZE=16384
export SAVEHIST=8192

export LANG=en_US.UTF8

if [ "$TERM" = "xterm" ]
then
    export TERM=xterm-256color
fi

export EDITOR=nvim
export VIMHOME="${HOME}/.vim"
export BROWSER=google-chrome-beta

# PATH for local bin directory.
if [ -z "$(echo ${PATH} | grep '^${HOME}/local/bin')" ] ; then
    export PATH="${HOME}/local/bin:${PATH}"
    export LD_LIBRARY_PATH="${HOME}/local/lib:${LD_LIBRARY_PATH}"
    export MANPATH="${HOME}/local/man:${MANPATH}"
fi

# PATH for binaries installed by cabal.
if [ -z "$(echo ${PATH} | grep '^${HOME}/.cabal/bin')" ] ; then
    export PATH="${HOME}/.cabal/bin:${PATH}"
fi

if [ -d ${HOME}/local/src/rust/src ] ; then
    export RUST_SRC_PATH=${HOME}/local/src/rust/src
fi

if [ -f  /home/michal/.nix-profile/etc/profile.d/nix.sh ] ; then
    source /home/michal/.nix-profile/etc/profile.d/nix.sh
fi

[ -f ~/.zshenv_local ] && source $HOME/.zshenv_local
