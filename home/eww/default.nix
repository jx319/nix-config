{ lib, pkgs, inputs, config, ... }: {
	programs.eww = {
		enable = true;
		package = inputs.eww.packages.${pkgs.system}.eww-wayland;
		configDir = ../eww;
	};
}
