# Linux only config
{ pkgs, lib, config, ... }:

{
  imports = [
    ./config/copyq.nix
    ./config/dunst.nix
    ./config/gammastep.nix
    ./config/keychain.nix
    #./config/niri.nix
    ./config/rofi.nix
    ./config/swayidle.nix
    ./config/swaylock.nix
    ./config/waybar.nix
  ];
}
