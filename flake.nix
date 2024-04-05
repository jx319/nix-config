{
  description = "nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old-pipewire.url = "github:nixos/nixpkgs?rev=68befa13bb19eff9aa59d124b6d5801b99e26bc2"; # no audio in newest PW/WP

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround
    };
    hyprlock.url = "github:hyprwm/hyprlock";
    hypridle.url = "github:hyprwm/hypridle";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
 
    ags.url = "github:Aylur/ags";

    nixpkgs-anyrun.url = "github:nixos/nixpkgs?rev=3030f185ba6a4bf4f18b87f345f104e6a6961f34";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs-anyrun"; # don't rebuild anyrun every time nixpkgs updates
    };
    
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nwg-displays.url = "github:nwg-piotr/nwg-displays";

    helix.url = "github:helix-editor/helix";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    autoclicker = {
      url = "github:konkitoman/autoclicker?rev=063ae7c942a9ee2f1f9684e387a850535eb65e31";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
	      modules = let nixosConfiguration = "laptop"; in [
          
          ./host/laptop/configuration.nix
          ./nixos/laptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jonas = import ./home;
              extraSpecialArgs = { inherit inputs nixosConfiguration; };
            };
          }
        ];
      };
    };
  };
}
