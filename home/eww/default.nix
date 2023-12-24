{ pkgs, inputs, ... }: {
	programs.eww = {
		enable = true;
		package = inputs.nixpkgs-wayland.packages.${pkgs.system}.eww-wayland;
		configDir = ../eww;
	};
}
