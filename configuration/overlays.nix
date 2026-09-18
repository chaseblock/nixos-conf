# Nixpkgs overlays: upstream fixes we need before they reach a release.
{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Temporary fix for xwayland satellite issue. Drop after updating xwayland.
      xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (final.fetchpatch {
            name = "xwayland-satellite-never-focus-override-redirect-popups.patch";
            url = "https://github.com/Supreeeme/xwayland-satellite/commit/add2795134593faafce60e404a0a75df68e9ee0c.patch";
            hash = "sha256-/1zJYAIHC+xiVytHH5HDt83lZKLBGQQdAoS/y2ObTLc=";
          })
        ];
      });
    })
  ];
}
