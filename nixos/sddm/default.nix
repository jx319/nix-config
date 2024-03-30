{ ... }:
{
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # theme = "${import ../../pkgs/catppuccin-sddm { inherit pkgs; }}";
  };
}
