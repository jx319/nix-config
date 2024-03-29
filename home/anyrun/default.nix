{ inputs, pkgs, ... }:
{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.dictionary
        inputs.anyrun.packages.${pkgs.system}.kidex
        inputs.anyrun.packages.${pkgs.system}.randr
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.shell
        inputs.anyrun.packages.${pkgs.system}.symbols
        inputs.anyrun.packages.${pkgs.system}.translate
        inputs.anyrun.packages.${pkgs.system}.websearch
      ];
      y = { fraction = 0.1; };
      width = { fraction = 0.3; };
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
    extraCss = ''
      ${builtins.readFile ./style.css}
    '';

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 7,
          terminal: Some("alacritty"),
        )
      '';
      "websearch.ron".text = ''
        Config(
          prefix: "",
          engines: [DuckDuckGo, Google]
        )
      '';
      "randr.ron".text = ''
        Config(
          prefix: ":dp",
          max_entries: 5, 
        )
      '';
    };
  };
}
