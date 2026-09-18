# other stuff that should be included for desktop
{ config, pkgs, ... }:

{
  imports = [ ./additional_userfacing.nix ];

  hardware.bluetooth.powerOnBoot = true;
}
