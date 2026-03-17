# Stuff
{ config, pkgs, ... }:
let
  # https://github.com/hummer12007/brightnessctl/issues/90
  newBrightnessctl = pkgs.brightnessctl.overrideAttrs (old: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "Hummer12007";
      repo = "brightnessctl";
      rev = "e70bc55cf053caa285695ac77507e009b5508ee3";
      sha256 = "sha256-agteP/YPlTlH8RwJ9P08pwVYY+xbHApv9CpUKL4K0U0=";
    };
    postPatch = ''
      substituteInPlace configure \
        --replace-fail "pkg-config" "$PKG_CONFIG"

      substituteInPlace 90-brightnessctl.rules \
        --replace-fail /bin/ ${pkgs.coreutils}/bin/
    '';
    configurePhase = "./configure --enable-logind";
  });
in
{
  fonts.packages = with pkgs; [
    nerd-fonts.proggy-clean-tt
    nerd-fonts.fantasque-sans-mono
  ];

  programs.firefox.enable = true;

  services.tailscale.enable = true;

  services.syncthing = {
    enable = true;
    user = "theopn";
    dataDir = "/home/theopn/Sync";
    configDir = "/home/theopn/.config/syncthing";

    overrideDevices = false;
    overrideFolders = false;
  };

  environment.systemPackages = with pkgs; [
    # paying the price for doing the minimal install
    curl wget gcc gdb git killall
    gnumake zip unzip file jq

    # Propritery apps
    chromium discord slack spotify zoom-us

    kicad

    # Niri related
    xwayland-satellite
    dunst rofi swaybg swaylock swayidle waybar
    copyq pavucontrol playerctl gammastep wf-recorder networkmanagerapplet
    newBrightnessctl #brightnessctl

    # Nvim LSP
    tree-sitter bash-language-server
    # order matters since both provides `clangd` command
    clang-tools clang

    vim
    alacritty
  ];
}
