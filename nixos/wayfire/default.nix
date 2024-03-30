{ pkgs, ... }:
{
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wayfire-plugins-extra
      wf-shell
    ];
  };
}
