{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tree
    exiftool
    openconnect
    #stow
    #figlet
    ffmpeg
    imagemagick
    #tmux
    hugo
    figlet
    wget

    nodejs_24
    python3
    #r
    cargo
    rustc
    sqlite
    qemu
  ];
}

