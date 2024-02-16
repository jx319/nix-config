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
      #inputs.nixpkgs.follows = "nixpkgs"; # MESA/OpenGL HW workaround
    };
 
    ags.url = "github:Aylur/ags";
    
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    nwg-displays.url = "github:nwg-piotr/nwg-displays";

    helix.url = "github:helix-editor/helix";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; 
	      modules = let nixosConfiguration = "nixos"; in [
          
          ./host/nixos/configuration.nix
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
