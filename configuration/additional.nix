# other stuff
{ config, pkgs, ... }:

{

  fonts.packages = with pkgs; [
    nerd-fonts.proggy-clean-tt
    nerd-fonts.fantasque-sans-mono
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
    gimp kicad libreoffice zotero

    # Propritery
    chromium discord slack spotify zoom-us
  ];


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
