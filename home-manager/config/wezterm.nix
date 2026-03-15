{ ... }:
{
  # Use Homebrew casks in macOS
  # programs.wezterm = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  home.file.".config/wezterm/wezterm.lua".source = ../../wezterm/wezterm.lua;
}

