{ pkgs, ... }:
{  
  qt = {
      enable = true;
      platformTheme = "qtct";
      style = {
        name = "kvantum";
      };
  };
  
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" { 
    General.theme = "Catppuccin-Mocha-Green";
  };
  
  xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "qt5ct.conf" {
    Appearance = {
      icon_theme = "Papirus-Dark";
      style = "kvantum";
    };
    Fonts = {
      fixed = ''"JetBrainsMono Nerd Font,12,-1,5,50,0,0,0,0,0,Regular"'';
      general = ''"JetBrainsMono Nerd Font Propo,12,-1,5,50,0,0,0,0,0,Regular"'';
    };
  };

  home.packages = with pkgs; [
    (catppuccin-kvantum.override {
      accent = "Green";
      variant = "Mocha";
    })
  ];
}
