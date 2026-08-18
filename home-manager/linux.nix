# Linux only config
{ pkgs, ... }:

{
  imports = [
    ## Niri
    ./config/dunst.nix
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

      font-name = "Noto Sans 12";
      document-font-name = "Noto Sans 12";

      font-antialiasing = "rgba";
      font-hinting = "slight";
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
    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 12;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };
}
