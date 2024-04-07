{ pkgs, ... }:
{  
  # qt = {
  #   enable = true;
  #   platformTheme = "qtct";
  #   style = {
  #     name = "Lightly";
  #     package = pkgs.kdePackages.callPackage ../../pkgs/lightly-qt6 { };
  #   };
  # };
  
  # xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" { 
  #   General.theme = "Catppuccin-Mocha-Green";
  # };
  
  xdg.configFile."qt6ct/qt6ct.conf".source = (pkgs.formats.ini {}).generate "qt6ct.conf" {
    Appearance = {
      icon_theme = "Papirus-Dark";
      style = "Lightly";
      color_scheme_path = "${./Catppuccin-Mocha.conf}";
      custom_palette = true;
    };
    Fonts = {
      fixed = ''"JetBrainsMono Nerd Font,12,-1,5,50,0,0,0,0,0,Regular"'';
      general = ''"JetBrainsMono Nerd Font Propo,12,-1,5,50,0,0,0,0,0,Regular"'';
    };
  };

  xdg.configFile."qt6ct/colors/Catppuccin-Mocha.conf".source = ./Catppuccin-Mocha.conf;

  home.packages = with pkgs; [
    (pkgs.kdePackages.callPackage ../../pkgs/lightly-qt6 { })
    qt6ct
  ];
}
