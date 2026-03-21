# Linux only config
{ pkgs, lib, config, ... }:

{
  imports = [
    ./config/copyq.nix
    ./config/keychain.nix
    ./config/zathura.nix

    # Niri
    ./config/dunst.nix
    ./config/gammastep.nix
    ./config/niri.nix
    ./config/rofi.nix
    ./config/swayidle.nix
    ./config/swaylock.nix
    ./config/waybar.nix
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      cursor-size = 24;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
