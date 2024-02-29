{ pkgs, inputs, ... }: {
	programs.eww = {
		enable = true;
		package = inputs.nixpkgs-wayland.packages.${pkgs.system}.eww;
		configDir = ../eww;
	};

	home.packages = with pkgs; [
		acpi
		brightnessctl
		jq
		pamixer
		socat
		wlogout
	];
}
