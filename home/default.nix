{ inputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default

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

  nixpkgs = {
    overlays = [
      inputs.catppuccin-alacritty-theme.overlays.default
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "jonas";
    homeDirectory = "/home/jonas";
    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct"; 
    };
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
