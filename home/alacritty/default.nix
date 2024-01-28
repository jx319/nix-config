{ pkgs, inputs, ... }: 
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        inputs.alacritty-theme.packages.${pkgs.system}.catppuccin_mocha
      ];

      font.normal.family = "JetBrains Mono Nerd Font";

      window = {
        opacity = 0.7;
        blur = true;
      };

      scrolling = {
        history = 100000;
      };
    };
  };
}
