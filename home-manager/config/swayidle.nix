{ pkgs, ... }:

let
  clock-screen = pkgs.callPackage ./clock-screen.nix { };
in
{
  services.swayidle = {
    enable = true;
    extraArgs = [ "-w" ];

    systemdTargets = [ "niri.service" ];

    events = {
      # Not clock-screen: we are on the way down, blanking buys nothing and the
      # monitors have to come back on at resume anyway.
      "before-sleep" = "${pkgs.swaylock}/bin/swaylock -f";
    };

    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      }
      {
        # Locks and blanks in one step, so the monitors go off the moment the
        # screen locks rather than two minutes later.
        timeout = 300;
        command = "${clock-screen}/bin/clock-screen";
        resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      }
      {
        timeout = 540;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
