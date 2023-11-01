{ config, pkgs, ... }:

{
	xdg.configFile."tofi/config".source = (pkgs.formats.ini {}).generate {
		anchor = "top";
		width = "100%";
		height = "30";
		horizontal = true;
		font-size = 16;
		font = "${pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFontPropo-Regular.ttf";
		prompt-text = ''""'';
		background-color = "#1e1e2e";
		selection-color = "#a6e3a1";
	};
}
