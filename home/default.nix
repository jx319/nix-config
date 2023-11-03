{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./tofi
    ./zellij
    ./swayosd
    ./git
    ./hyprland
    ./eww
    ./helix
    ./kitty
    ./wofi
    ./alacritty
    ./dunst
  ];

  home = {
    username = "jonas";
    homeDirectory = "/home/jonas";
    packages = with pkgs; [
      (catppuccin-kvantum.override {
        accent = "Green";
        variant = "Mocha";
      })
    ];
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  
  gtk = {
  	enable = true;
	  theme = {
  		name = "Catppuccin-Mocha-Standard-Green-Dark";
	    package = pkgs.catppuccin-gtk.override {
		    accents = [ "green" ];
        size = "standard";
		    variant = "mocha";
  		};
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "green";
      };
    };
    font = {
      name = "JetBrainsMono Nerd Font Propo";
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Green-Cursors";
      package = pkgs.catppuccin-cursors.mochaGreen;
      size = 32;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum";
    };
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" { General.theme = "Catppuccin-Mocha-Green"; };
  xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "qt5ct.conf" {
    Appearance = {
      icon_theme = "Papirus-Dark";
      style = "kvantum";
    };
    Fonts = {
      fixed = ''"JetBrainsMono Nerd Font,12,-1,5,50,0,0,0,0,0,Regular"'';
      general = ''"JetBrainsMono Nerd Font Propo,12,-1,5,50,0,0,0,0,0,Regular"'';
    };
  };
  
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
