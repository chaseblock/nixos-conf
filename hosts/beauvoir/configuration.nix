{ pkgs, ... }:

let
  saymyname = "theopn";  # you are goddamn right
in
{
  imports = [
    ./aerospace.nix
    ./homebrew.nix
  ];

  environment.variables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    LESSHISTFILE = "-";
  };

  # enable Fish in system level.
  # ensures $PATH is set correctly,
  # even when you launch app through Spotlight.
  programs.fish.enable = true;
  users.users.${saymyname} = {
    name = saymyname;
    home = "/Users/${saymyname}";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.proggy-clean-tt
    nerd-fonts.fantasque-sans-mono
  ];

  system.primaryUser = saymyname;
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.1;          # how long to hold the mouse
      autohide-time-modifier = 0.3;  # animation speed
      orientation = "left";
      persistent-apps = [
      {
        spacer = {
          small = false;
        };
      }
      ];
      persistent-others = [
          { folder = "/Users/${saymyname}/Downloads"; }
      ];
      showhidden = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };
    screencapture = {
      type = "png";
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # Let Determinate Nix win
  nix.enable = false;

  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
}
