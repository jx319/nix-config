{ ... }:
{
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
    # theme = "${import ../../pkgs/catppuccin-sddm { inherit pkgs; }}";
  };
}
