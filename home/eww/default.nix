{ lib, pkgs, inputs, config, ... }: {
	programs.eww = {
		enable = true;
		configDir = ../eww;
	};
}
