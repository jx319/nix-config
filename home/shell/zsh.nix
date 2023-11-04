{ ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      rb = "sudo nixos-rebuild switch --flake ~/nix-config#nixos";
    };
  };
}
