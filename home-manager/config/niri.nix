{ pkgs, config, ... }:

{
  # !!!!! Since home-manager is not yet to merge Niri flake,
  # Niri service installation and dependenceis are handled in
  # hosts/wittgenstein/niri.nix (which is included in configuration.nix).
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
}
