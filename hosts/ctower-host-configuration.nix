{ config, pkgs, ... }:
{
  networking.hostName = "ctower";

  # Enable ssh
  services.openssh.enable = true;
}
