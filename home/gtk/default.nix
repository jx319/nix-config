{ pkgs, ... }:
{
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
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "green";
      };
    };
    font = {
      name = "JetBrainsMono Nerd Font Propo";
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Green-Cursors";
      package = pkgs.catppuccin-cursors.mochaGreen;
      size = 32;
    };
  };
}
