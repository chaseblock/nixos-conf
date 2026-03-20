{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash fish
        c cpp
        java
        javascript
        lua
        make
        markdown markdown_inline
        nix
        regex
        python
        sql
        vim vimdoc
        json toml xml yaml
      ];
    };
  };
}
