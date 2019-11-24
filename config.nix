{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    michaltPkgs = pkgs.buildEnv {
      name = "michalt-pkgs";
      paths = [
        automake
        borgbackup
        cabal-install
        gitAndTools.diff-so-fancy
        dstat
        fzf
        haskell.compiler.ghc881
        git
        gmp
        gnumake
        htop
        ncurses
        neovim
        nodejs
        ormolu
        ripgrep
        tree-sitter
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
