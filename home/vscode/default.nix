{ pkgs, inputs, ... }:
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    package = pkgs.vscodium;

    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      (inputs.catppuccin-vsc.packages.${pkgs.system}.catppuccin-vsc.override {
        accent = "green";
        boldKeywords = true;
        italicComments = true;
        italicKeywords = true;
        extraBordersEnabled = false;
        workbenchMode = "default";
        bracketMode = "rainbow";
        colorOverrides = {};
        customUIColors = {};
      })
      catppuccin.catppuccin-vsc-icons

     	fireblast.hyprlang-vscode 	
      
      jasew.vscode-helix-emulation
      
      jnoortheen.nix-ide

      ms-python.python
      
      ms-vscode.cpptools-extension-pack
      
      redhat.java
     	rust-lang.rust-analyzer
    ];
    
    userSettings = {
      "chat.editor.fontSize" = 16;
      
      "debug.console.fontSize" = 16;
    
      "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      
      "files.autoSave" = "afterDelay";

      "markdown.preview.fontSize" = 16;
      
      "telemetry.telemetryLevel" = "off";

      "terminal.integrated.fontSize" = 16;

      "window.customTitleBarVisibility" = "auto";
      "window.dialogStyle" = "custom";
      "window.menuBarVisibility" = "visible";
      "window.titleBarStyle" = "custom";

      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
    };
  };
}
