{ pkgs, ... }:
{
  programs.neovide= {
    enable = true;
    settings = {
      frame = "full";
      title-hidden = true;
      font = {
        normal = [ "FantasqueSansM Nerd Font" "ProggyClean Nerd Font" "ComicCodeLigatures Nerd Font" ];
        size = 16.0;
      };
    };
  };
}

