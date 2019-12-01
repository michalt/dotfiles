export BROWSER=chromium
export EDITOR=nvim
# This is apparently needed for nixos
# https://github.com/Gabriel439/bench/issues/40#issuecomment-542827814
export LANG=C.UTF-8
#export LANG=en_US.UTF-8


# PATH for ~/.local
if [[ ! ("${PATH}" =~ ".*${HOME}/.local/bin.*") ]] ; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# Currently unused
# if [[ ! ("${PATH}" =~ ".*${HOME}/.ghcup.*") ]] && \
#     [ -f "${HOME}/.ghcup/env" ]; then
#   source "${HOME}/.ghcup/env"
# fi

# Currently unused
if [[ ! ("${PATH}" =~ ".*${HOME}/.cargo/bin.*") ]]; then
  export PATH="${HOME}/.cargo/bin:${PATH}"
fi

# PATH for binaries installed by cabal.
if [[ ! ("${PATH}" =~ ".*/.cabal/bin.*") ]]; then
  export PATH="${HOME}/.cabal/bin:${PATH}"
fi

if [[ ! ("${PATH}" =~ ".*/.nix-profile/bin.*") ]] && \
    [ -f  "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
fi

if [[ ! ("${LD_LIBRARY_PATH}" =~ ".*/.nix-profile/lib.*") ]]; then
  export LD_LIBRARY_PATH="${HOME}/.nix-profile/lib:${LD_LIBRARY_PATH}"
fi

[ -f ~/.zshenv_local ] && source "${HOME}/.zshenv_local"
