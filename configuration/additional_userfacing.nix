# packages for user-facing systems (laptops, desktops, etc.)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # misc open source GUI tools
    gimp kicad libreoffice zotero pithos openscad
    emacs

    # Propritery
    chromium spotify zoom-us

    # Chat/messaging applications
    discord slack mattermost-desktop fedistar element-desktop

    # vpn
    openconnect networkmanager-openconnect
  ];
}
