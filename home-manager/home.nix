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
   ./config/fd.nix
  #  ./config/fzf.nix
    ./config/git.nix
  #  ./config/lf.nix
   ./config/ripgrep.nix
  #  ./config/syncthing.nix
    ./config/vim.nix
    ./config/emacs.nix
  #  ./config/zoxide.nix
    ./config/vscode.nix
    ./config/direnv.nix

  #  # Terminal & Shell
    ./config/fastfetch.nix
    ./config/kitty.nix
    ./config/zsh.nix
  ];

  home.packages = with pkgs; [
    # tools
    wget
    kitty
    tigervnc

    # media
    ffmpeg imagemagick
    pywal

    # coding tools
    python3
    sbt
    code-cursor

    # misc
    fortune
  ];

  # Allow unfree when using nix-shell
  # Need to do this by copying a file to the right spot
  home.file = {
    ".config/nixpkgs" = {
      source = dots/nixpkgs;
      recursive = true;
    };
  };

  programs.man.generateCaches = true;
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
