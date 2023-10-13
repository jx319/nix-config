{ pkgs, config, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      auto_layout = false;
    };
  };
}
