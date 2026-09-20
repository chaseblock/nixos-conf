# other stuff that should be included for desktop
{ config, pkgs, ... }:

{
  imports = [ ./additional_userfacing.nix ];

  hardware.bluetooth.powerOnBoot = true;

  # Steam
  programs.steam.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
  };

  # Tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      set mouse
    '';
  };
}
