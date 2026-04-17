# other stuff
{ config, pkgs, ... }:

{

  fonts.packages = with pkgs; [
    nerd-fonts.proggy-clean-tt
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    cantarell-fonts
    noto-fonts-cjk-sans  # for Korean input
  ];

  programs.thunderbird.enable = true;

  environment.systemPackages = with pkgs; [
    # various necessary packages
    curl wget gcc gdb git killall
    gnumake zip unzip file jq
    gnome-disk-utility

    # misc open source GUI tools
    gimp kicad libreoffice zotero pithos openscad

    # Propritery
    chromium spotify zoom-us

    # Chat/messaging applications
    discord slack mattermost-desktop fedistar element-desktop

    # vpn
    openconnect networkmanager-openconnect
  ];

  # Enable unstable
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

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


  # https://wiki.nixos.org/wiki/Tailscale
  services.tailscale.enable = true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
    systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # default applications
  # ls -l /run/current-system/sw/share/applications/ /etc/profiles/per-user/${USER}/share/applications/
  xdg.mime.defaultApplications = {
      "text/html"                       = [ "firefox.desktop" ];
      "application/xhtml+xml"           = [ "firefox.desktop" ];
      "x-scheme-handler/http"           = [ "firefox.desktop" ];
      "x-scheme-handler/https"          = [ "firefox.desktop" ];
      "x-scheme-handler/about"          = [ "firefox.desktop" ];
      "x-scheme-handler/unknown"        = [ "firefox.desktop" ];
      "x-scheme-handler/mailto"         = [ "firefox.desktop" ];

      "image/*" = [
        "imv-dir.desktop"
        "gimp.desktop"
      ];

      "video/*" = "mpv.desktop";
      "audio/*" = "mpv.desktop";

      "application/pdf"         = "org.pwmt.zathura.desktop";
      "application/epub+zip"    = "org.pwmt.zathura.desktop";

      "text/*" = "neovide.desktop";

      "inode/directory" = "lf.desktop";
  };
}
