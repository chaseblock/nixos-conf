{ ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;

    extraConfig = builtins.readFile ./vim/.vimrc;
  };
}
