{ pkgs, inputs, ... }: {
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

    themes = {
      catppuccin_mocha_transparent = {
        inherits = "catppuccin_mocha";
        "ui.background" = "none";
      };
    };

    extraPackages = with pkgs; [
      rust-analyzer
      marksman
      nil
      nodePackages.typescript-language-server
    ];
  };
  
}
