{ inputs, pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    package = inputs.nixpkgs-old-pipewire.legacyPackages.${pkgs.system}.pipewire;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    wireplumber = {
      enable = true;
      package = inputs.nixpkgs-old-pipewire.legacyPackages.${pkgs.system}.wireplumber;
    };
  };
}
