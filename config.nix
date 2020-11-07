{
  build-max-jobs=16;
  build-cores=16;
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    michaltPkgs = pkgs.buildEnv {
      name = "michalt-pkgs";
      paths = [
        automake
        bat
        borgbackup
        cabal-install
        cargo-edit
        ccache
        clang_10
        cmake
        gitAndTools.delta
        gperftools
        dstat
        detox
        fzf
        haskell.compiler.ghc8102
        git
        gmp
        gnumake
        htop
        llvm_10
        ncurses
        neovim
        ninja
        nodejs
        ripgrep
        rustup
        stack
        stow
        tokei
        tmux
        tmuxPlugins.fzf-tmux-url
        tmuxPlugins.sensible
        tmuxPlugins.tmux-colors-solarized
        tmuxPlugins.vim-tmux-navigator
        zlib
        zlib.dev
        zsh
        zsh-syntax-highlighting
        zstd
      ];
    };
  };
}
