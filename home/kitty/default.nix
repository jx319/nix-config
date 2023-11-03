{ ... }: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font.name = "JetBrains Mono Nerd Font";
    extraConfig = "confirm_os_window_close 0";
  };
}
