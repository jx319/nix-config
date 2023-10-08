{ lib, pkgs, config, inputs, ... }: {
  programs.helix = { 
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        cursor-shape = {
          insert = "bar";
        };
      };
    };
  };
  
}
