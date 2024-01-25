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
    libsForQt5.kmenuedit
    mpv
    nil
    packwiz
    pods
    polychromatic
    python3
    signal-desktop
    vitetris
    xfce.thunar
    xfce.thunar-volman
  ];
}
