# other stuff that should be included for laptops
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

  # Sleep settings
  systemd.sleep.settings.Sleep = {
    AllowSuspend = "yes";
    AllowHibernation = "yes";
    AllowHybridSleep = "yes";
    AllowSuspendThenHibernate = "yes";
    HibernateDelaySec = "1h";
  };

  services.logind.settings.Login = {
    KillUserProcesses = false;
    HandleLidSwitch="suspend-then-hibernate";
    HandleLidSwitchExternalPower="suspend-then-hibernate";
    HandleLidSwitchDocked="suspend-then-hibernate";
  };
}
