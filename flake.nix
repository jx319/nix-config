{
  description = "nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
    eww.url = "github:elkowar/eww";
    eww.inputs.rust-overlay.follows = "rust-overlay";
    
    catppuccin-alacritty-theme.url = "github:ohlus/catppuccin-alacritty-theme.nix";

    nwg-displays.url = "github:nwg-piotr/nwg-displays";

    helix.url = "github:helix-editor/helix";
    };

  outputs = { nixpkgs, home-manager, catppuccin-alacritty-theme, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
	      modules = [ 
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ catppuccin-alacritty-theme.overlays.default ]; })
          ./nixos/configuration.nix 
        ];
      };
    };

    homeConfigurations = {
      "jonas@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; 
	      extraSpecialArgs = { inherit inputs; };
        modules = [ ./home ];
      };
    };
  };
}
