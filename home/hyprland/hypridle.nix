{ config, inputs, lib, ... }:
{
  imports = [
    inputs.hypridle.homeManagerModules.default
  ];

  services.hypridle = {
    enable = true;
    lockCmd = lib.getExe config.programs.hyprlock.package;
    unlockCmd = "pkill hyprlock";
    beforeSleepCmd = lib.getExe config.programs.hyprlock.package;
  };
}
