{ inputs, pkgs, ... }:
{
  # packages to add to home PATH that aren't added by any modules
  home.packages = with pkgs; [
    amberol
    (pkgs.callPackage ../../pkgs/autoclicker { inherit inputs; })
    btop
    distrobox
    glxinfo
    hyprpicker
    libreoffice
    mpv
    packwiz
    pods
    polychromatic
    python3
    signal-desktop
    vitetris
    pavucontrol
    qpwgraph
    tangram
  ];
}
