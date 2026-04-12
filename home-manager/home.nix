{ pkgs, lib, config, ... }:

{
  #xdg.enable = true;

  home.sessionVariables = {
    XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures";
    XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
  };

  imports = [
  #  # Tools
    ./config/bat.nix
    ./config/btop.nix
    ./config/eza.nix
  #  ./config/fd.nix
  #  ./config/fzf.nix
    ./config/git.nix
  #  ./config/lf.nix
  #  ./config/ripgrep.nix
  #  ./config/syncthing.nix
    ./config/vim.nix
  #  ./config/zoxide.nix

  #  # Terminal & Shell
    ./config/fastfetch.nix
    ./config/kitty.nix
    ./config/zsh.nix
  ];

  home.packages = with pkgs; [
    # tools
    wget
    kitty

    # media
    ffmpeg imagemagick
    pywal

    # python
    python3

    # coding
    vscode code-cursor
  ];

  programs.man.generateCaches = true;
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
