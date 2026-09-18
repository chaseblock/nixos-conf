# other stuff that should be included for laptops
{ config, pkgs, ... }:

{
  imports = [ ./additional_userfacing.nix ];
  
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
