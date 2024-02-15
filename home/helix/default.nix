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
        
        auto-save = true;
        bufferline = "multiple";

        statusline = {
          right = [
            "diagnostics"
            "selections"
            "register" 
            "position"
            "position-percentage"
            "file-encoding"
          ];
        };
        
        lsp = {
          display-inlay-hints = true;
        };

        indent-guides = {
          render = true;
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
      vscode-langservers-extracted
    ];
  };
  
}
