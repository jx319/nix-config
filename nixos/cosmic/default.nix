{ inputs, lib, ... }:
{
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  services = {
    #displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
  };

  hardware.pulseaudio.enable = lib.mkForce false;
}
