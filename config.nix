{
  build-max-jobs=16;
  build-cores=16;
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    michaltPkgs = pkgs.buildEnv {
      name = "michalt-pkgs";
      paths = [
        automake
        borgbackup
        cabal-install
        cargo-edit
        ccache
        cmake
        gitAndTools.delta
        gperftools
        dstat
        detox
        haskell.compiler.ghc8103
        git
        gmp
        gnumake
        htop
        ormolu
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
        tmuxPlugins.sensible
        tmuxPlugins.tmux-colors-solarized
        tmuxPlugins.vim-tmux-navigator
        zlib
        zlib.dev
        zstd
      ];
    };
  };
}
