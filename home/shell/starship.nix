{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "[┌──](bold green)[\\[](bold green) $directory$package$git_branch$nix_shell$all[\\]](bold green)"
        "$line_break"
        "[└─](bold green)$character"
      ];
      scan_timeout = 10;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✖](bold red)";
      };
    };
  };
}
