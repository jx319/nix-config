{ pkgs, ... }: 
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        pkgs.catppuccin-alacritty-theme.catppuccin-mocha
      ];

      font.normal.family = "JetBrains Mono Nerd Font";
    };
  };
}
