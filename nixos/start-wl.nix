{ pkgs }:

pkgs.writeShellScriptBin "start-wl"''
        ${pkgs.swww}/bin/swww init &
        ${pkgs.swww}/bin/swww img ~/.config/hypr/nix-wallpaper-dracula.png &

        #${pkgs.waybar}/bin/waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &
        ${pkgs.dunst}/bin/dunst
''
