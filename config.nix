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
        ccache
        clang_9
        cmake
        gitAndTools.diff-so-fancy
        dstat
        detox
        fzf
        haskell.compiler.ghc881
        git
        gmp
        gnumake
        htop
        llvm_9
        ncurses
        neovim
        ninja
        nodejs
        ripgrep
        rustup
        stack
        tree-sitter
        tokei
        tmux
        tmuxPlugins.fzf-tmux-url
        tmuxPlugins.sensible
        tmuxPlugins.tmux-colors-solarized
        tmuxPlugins.vim-tmux-navigator
        xz
        zsh
        zsh-syntax-highlighting
      ];
    };
  };
}
