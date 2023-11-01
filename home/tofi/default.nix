{ config, pkgs, lib, ... }:

{
	xdg.configFile."tofi/config".text = ''
		anchor = top
		width = 100%
		height = 45
		horizontal = true
		font-size = 16
		font = ${pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFontPropo-Regular.ttf
		prompt-text = ">"
		background-color = #1e1e2e
		selection-color = #a6e3a1
		outline-width = 0
		border-width = 0
		padding-top = 5
		padding-bottom = 5
		padding-left = 5
		padding-right = 5
		result-spacing = 25
		drun-launch = true'';
}
