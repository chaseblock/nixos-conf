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

    # Keyring management GUI (change the login keyring password, inspect secrets).
    seahorse
  ];

  # Run Electron/Chromium apps natively on Wayland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.passwd.enableGnomeKeyring = true;
}
