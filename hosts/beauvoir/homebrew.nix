{ ... }:

let
  externalAppDir = "/Volumes/theo-crucial-p310/Applications";
in
{

  homebrew = {
    enable = true;
    casks = [
      # Dev tools
      "docker-desktop"
      #{
      # name = "docker-desktop";
      # args = { appdir = externalAppDir };
      #}
      #"intellij-idea"
      "macvim-app"
      #"rstudio"
      #"wezterm"

      # Fun
      "discord"
      #"minecraft"
      "spotify"

      # Productivity
      "itsycal"
      "notion"

      # Sync
      "cryptomator"
      "filen"
      #{
      # name = "filen";
      # args = { appdir = externalAppDir };
      #}
      "syncthing-app"
      #{
      # name = "syncthing-app";
      # args = { appdir = externalAppDir };
      #}

      # System
      "jordanbaird-ice"
      "maccy"
      "stats"

      # Tools
      "bitwarden"
      #{
      # name = "bitwarden";
      # args = { appdir = externalAppDir };
      #}
      #"cemu"
      "gimp"
      #{
      # name = "gimp";
      # args = { appdir = externalAppDir };
      #}
      "keycastr"
      #{
      # name = "keycastr";
      # args = { appdir = externalAppDir };
      #}
      "kicad"
      "obs"
      #{
      # name = "obs";
      # args = { appdir = externalAppDir };
      #}
      "skim"
      "vlc"
      #{
      # name = "vlc";
      # args = { appdir = externalAppDir };
      #}
      "zotero"
      #{
      # name = "zotero";
      # args = { appdir = externalAppDir };
      #}

      # Web
      "firefox"
      "tailscale-app"
      "thunderbird"
      #{
      # name = "ungoogled-chromium";
      # args = { appdir = externalAppDir };
      #}
      "ungoogled-chromium"
    ];

    # Delete unspecified Homebrew formulae
    onActivation.cleanup = "zap";
  };
}
