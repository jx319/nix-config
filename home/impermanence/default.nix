{ inputs, ... }:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence."/persistent/home/jonas" = {
    hideMounts = true;
    directories = [
      "Desktop"
      "Downloads"
      "Musik"
      "Bilder"
      "Dokumente"
      "Videos"
      "Programmieren"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/flatpak"
      ".local/share/Trash"
      ".local/share/Tangram"
      ".local/share/qutebrowser"
      ".var/app"
      ".config/Signal"
      ".config/polychromatic"
    ];
    files = [
      ".config/hypr/monitors.conf"
    ];
    allowOther = true;
  };
}
