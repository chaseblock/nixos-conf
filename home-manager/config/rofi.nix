{ pkgs, lib, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  programs.rofi = {
    enable = true;

    plugins = [ pkgs.rofi-calc ];

    font = "ProggyClean Nerd Font 18";
    terminal = "${pkgs.kitty}/bin/kitty";

    modes = [
      "drun"
      "calc"
      "window"
    ];

    extraConfig = {
      kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
      kb-row-down = "Down,Control+j";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-remove-to-eol = "Control+Shift+e";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
      kb-remove-char-back = "BackSpace";

      line-margin = 10;
      display-ssh = "";
      display-run = "";
      display-drun = "";
      display-window = "";
      display-combi = "";
      show-icons = true;
    };
  };
}
