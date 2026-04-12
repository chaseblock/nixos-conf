{ config, pkgs, lib, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;

    plugins = [ pkgs.rofi-calc ];

    terminal = "${pkgs.kitty}/bin/kitty";

    modes = [
      "drun"
      "window"
      "calc"
    ];

    extraConfig = {
      kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
      kb-row-down = "Down,Control+j";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-remove-to-eol = "Control+Shift+e";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
      kb-remove-char-back = "BackSpace";

      line-margin = 10;
      display-ssh = " ";
      display-run = " ";
      display-drun = " ";
      display-window = " ";
      display-combi = " ";
      display-calc = " ";
      show-icons = true;
    };

    theme = "../../.cache/wal/colors-rofi-dark.rasi";
  };
}
