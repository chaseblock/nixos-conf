{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.vimtex = {
      zathuraPackage = pkgs.zathura;

      enable = true;

      settings = {
        compiler_method = "latexmk";
        tex_flavor = "latex";

        # --shell-escape allows use of external tools
        # e.g., minted requiring pygmentize
        compiler_latexmk = {
          options = [
            "-shell-escape"
            "-verbose"
            "-file-line-error"
            "-synctex=1"
            "-interaction=nonstopmode"
          ];
        };

        view_method = "zathura";
      };
    };
  };
}
