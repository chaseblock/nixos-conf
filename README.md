# Theo's Nix Flakes

I got peer-pressured to using Nix, so here is my attempt at migrating my [other dotfiles repository](https://github.com/theopn/dotfiles) to Nix.

## Wittgenstein (Framework 13 w/ AMD Ryzen ~AI~ 5 340)

- `hosts/wittgenstein/configuration.nix`: main NixOS configuration; hardware services, user & environment, etc.
- `hosts/wittgenstein/hardware-configuration.nix`: hardware configuration for Framework 13 AMD + modifications to use `/dev/by-label` and LUKS encryption
- `hosts/wittgenstein/tailscale.nix`
- `hosts/wittgenstein/niri.nix`: because home-manager does not provide Niri settings yet, this installs Niri, system-wide services (e.g., portals), and define shell script used in my config.
    Actual config is deployed in `home-manager/config/niri.nix`, and other tools with home-manager modules (e.g., dunst, swaylock, swayidle) are in home-manager.
    Temporary solution till the day Niri flake is merged to home-manager...
- `hosts/wittgenstein/idkwhattoname.nix`: every other services, packages, and settings

### Minimal NixOS Installation with LUKS

TODO

## Beauvoir (M4 Mac Mini)

- `hosts/beauvoir/configuration.nix`: `nix-darwin` configuration with Homebrew casks and system settings
- `hosts/beauvoir/aerospace.nix`: Nix translation of my Aerospace config

### Determinate Nix Installation & Bootstrap

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
nix run nix-darwin -- switch --flake .#beauvoir
```

## Home-manager

Largely the Nix rewrite of my [original dotfiles repository](https://github.com/theopn/dotfiles), but I tried to

1. use Nix modules whenever possible
2. unlike my original dotfiles, prefer third-party tools
3, only keep the features I use

- `home-manager/home.nix`: setting user-level config and importing cross-platform tools
- `home-manager/linux.nix`: importing Linux only tools (keychain, Rofi, ...)
- `home-manager/config`: all individual config files for programs/services.
    Sub-directories are for non-Nix config; for example, `home-manager/config/lf` has `icons_colored` file from the [official repository](https://github.com/gokcehan/lf/blob/master/etc/icons_colored.example).

