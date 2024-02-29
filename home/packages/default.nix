{ pkgs, ... }:
{
  # packages to add to home PATH that aren't added by any modules
  home.packages = with pkgs; [
    btop
    distrobox
    glxinfo
    hyprpicker
    ktorrent
    libreoffice
    # libsForQt5.kmenuedit
    kdePackages.kmenuedit
    mpv
    packwiz
    pods
    polychromatic
    python3
    signal-desktop
    vitetris
    amberol
    pavucontrol
    qpwgraph
    tangram
  ];
}
