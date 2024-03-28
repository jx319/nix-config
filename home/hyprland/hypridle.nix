{ config, inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.hypridle.homeManagerModules.default
  ];

  services.hypridle = {
    enable = true;
    lockCmd = lib.getExe config.programs.hyprlock.package;
    beforeSleepCmd = "loginctl lock-session";
    listeners = 
    let 
      brightnessctl = "${lib.getExe pkgs.brightnessctl}";
      hyprctl = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/hyprctl";
    in
    [
      {
        timeout = 150;
        onTimeout = "${brightnessctl} -s set 10%";
        onResume = "${brightnessctl} -r";
      }
      {
        timeout = 300;
        onTimeout = "loginctl lock-session";
      }
      {
        timeout = 330;
        onTimeout = "${hyprctl} dispatch dpms off";
        onResume = "${hyprctl} dispatch dpms on";
      }
      {
        timeout = 600;
        onTimeout = "systemctl suspend";
      }
    ];
  };
}
