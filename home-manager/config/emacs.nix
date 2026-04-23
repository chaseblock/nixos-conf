# This file and other emacs-related files are based on those
# from https://github.com/justinlime/dotfiles.

{ lib, config, inputs, pkgs, username, ... }:
let cfg = config.homeMods.emacs; in 
{
  programs.emacs.enable = true;

  home.packages = with pkgs; [
    # Runtime
    tree-sitter
    gcc 
    imagemagick
    zoxide
    ispell
    # PDF viewing
    ghostscript
    # Language Servers
    lua-language-server 
    nixd 
    samba
    go
    gopls 
    rust-analyzer
    zls #Zig
    clang-tools #C
    java-language-server
    typescript
    pyright
    vscode-langservers-extracted #HTML,CSS, JSON
    bash-language-server
    yaml-language-server
    # Fonts
    roboto
    nerd-fonts.fira-code
  ];
  xdg.configFile = {
    "emacs/early-init.el".source = ./emacs/early-init.el;
    "emacs/init.el".source = ./emacs/init.el;
    "emacs/config.org".source = ./emacs/config.org;
  };
}

