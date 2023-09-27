{ pkgs, ...}: 
pkgs.writeShellScriptBin "screenshot" ''
  grim -g "$(slurp)" - | convert - -shave 1x1 PNG:- | swappy -f -
''

