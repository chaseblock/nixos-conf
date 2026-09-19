{ pkgs, lib, config, ... }:

# The monitors benefit from slightly smaller font sizes
{
  programs.kitty.font.size = lib.mkForce 12.5;

  gtk.font.size = lib.mkForce 11;

  dconf.settings."org/gnome/desktop/interface" = {
    font-name = lib.mkForce "Noto Sans 11";
    document-font-name = lib.mkForce "Noto Sans 11";
  };
}
