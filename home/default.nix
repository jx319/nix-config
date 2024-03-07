{ ... }:

{
  imports = [
    ./packages

    ./ags
    ./alacritty
    ./anyrun
    ./eww
    ./eza
    ./git
    ./gitui
    ./gtk
    ./helix
    ./hyprland
    ./kdeconnect
    ./kitty
    ./obs
    ./qt
    ./qutebrowser
    ./shell
    ./swayfx
    ./swayosd
    ./tofi
    ./virt-manager
    ./vscode
    ./wofi
    ./zellij
  ];

  home = {
    username = "jonas";
    homeDirectory = "/home/jonas";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
