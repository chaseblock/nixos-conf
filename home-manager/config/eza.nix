{ ... }:

{
  programs.eza = {
    enable = true;

    # integration replaces `ls`
    enableZshIntegration = true;
    enableFishIntegration = true;

    colors = "auto";
    icons = "auto";  # only output if stdout = terminal
  };
}
