{ ... }:
{
  programs.zsh = {
    enable = true;

    defaultKeymap = "viins";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
      ];
      theme = "gentoo";
    };

    shellAliases = {
      cl = "clear";

      ga = "git add";
      gcm = "git commit -m";
      gss = "git status";

      # --git and --total-size are also useful, but omitted for performance
      l = "eza --color=auto --icons=auto  --long --all --header --time-style=long-iso";

      nv = "neovide --fork";
      v = "nvim";

      keychain_load = "eval $(keychain --eval id_ed25519 id_rsa)";
    };

    initContent = ''
      cat $HOME/.cache/wal/sequences

      # Display a fortune when starting zsh
      fortune
    '';
  };
}
