{ pkgs, ... }:

{
  home.packages = [
    # The 3D viewport comes up blank on the NVIDIA proprietary GL stack; the
    # override wraps the binary to route GL through Mesa + zink instead.
    # https://github.com/NixOS/nixpkgs/issues/498311
    (pkgs.bambu-studio.override { withNvidiaGLWorkaround = true; })
  ];
}
