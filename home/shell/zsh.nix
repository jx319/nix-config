{ nixosConfiguration, ... }:

{
  programs.zsh = {
    enable = true;
    
    shellAliases = {
      rb = "sudo nixos-rebuild switch --flake ~/nix-config#${nixosConfiguration}";
      pw = "packwiz";
    };

    autosuggestion = {
      enable = true;
    };

    autocd = true;

    syntaxHighlighting = {
      enable = true;
    };
  };
}
