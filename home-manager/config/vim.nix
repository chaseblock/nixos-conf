{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;

    extraConfig = builtins.readFile ./vim/.vimrc;

    plugins = with pkgs.vimPlugins; [
      vim-sleuth
    ];
  };
}
