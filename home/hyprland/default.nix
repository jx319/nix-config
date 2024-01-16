{ inputs, pkgs, ... }: 

{
  wayland.windowManager.hyprland = {
  	enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.hyprland;

		plugins = [
			inputs.hycov.packages.${pkgs.system}.hycov
		];

		settings = {
			# catppuccin colors
			"$green" = "0xffa6e3a1";
			"$surface1" = "0xff45475a";
			
			source = [
				# nwg-displays
				"~/.config/hypr/monitors.conf"
				"~/.config/hypr/workspaces.conf"
			];

			# daemons
			exec-once = [
				"hyprctl setcursor Catppuccin-Mocha-Green-Cursors 32"
				"${pkgs.swaybg}/bin/swaybg -i ${./nix-black-4k.png}"
				"${pkgs.hyprpaper}/bin/hyprpaper"
				"${pkgs.dunst}/bin/dunst"
				"${inputs.nixpkgs-wayland.packages.${pkgs.system}.eww-wayland}/bin/eww daemon"
				"${inputs.nixpkgs-wayland.packages.${pkgs.system}.eww-wayland}/bin/eww open bar"
				"${pkgs.swayosd}/bin/swayosd-server"
			];

			env = [
				"XCURSOR_SIZE,32"
				"QT_QPA_PLATFORMTHEME,qt5ct"
			];

			input = {		
				    kb_layout = "de";
				    follow_mouse = 1;
				    accel_profile = "flat";

				    touchpad = {
				        natural_scroll = true;
				    };

				    sensitivity = 0.3; # -1.0 - 1.0, 0 means no modification.
			};

			
			general = {
			    gaps_in = 5;
			    gaps_out = 20;
			    border_size = 2;
			    "col.active_border" = "$green";
			    "col.inactive_border" = "$surface1";
			    layout = "dwindle";
			};

			decoration = {
			    rounding = 10;
		      drop_shadow = true;
			    shadow_range = 4;
			    shadow_render_power = 3;
			    "col.shadow" = "$surface1";
			};

			animations = {
			    enabled = true;

			    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
											
			    animation = [
						"windows, 1, 7, myBezier, slide"
				    "windowsOut, 1, 7, myBezier, slide"
				    "border, 1, 10, default"
				    "borderangle, 1, 8, default"
				    "fade, 1, 7, default"
				    "workspaces, 1, 6, default"
					];
			};

			dwindle = {
			    pseudotile = true; 
					preserve_split = true;
			};

			master = {
			    new_is_master = true;
			};

			gestures = {
			    workspace_swipe = true;
			};
			
			misc = {
				disable_hyprland_logo = true;
			};
			
			# window rules
			windowrulev2 = [
				"float,class:(prismlauncher)"
				"float,class:(xdg-desktop-portal-gtk)"
				"float,class:(polkit-kde-authentication-agent-1)"
				"float,class:(nwg-displays)"
			];
			
			# keybinds
			"$mainMod" = "SUPER";

			bind = [
				"$mainMod, Q, exec, alacritty"
				"$mainMod, C, killactive"
				"$mainMod, M, exit"
				"$mainMod, E, exec, ${pkgs.libsForQt5.dolphin}/bin/dolphin"
				"$mainMod, V, togglefloating"
				"$mainMod, R, exec, ${pkgs.tofi}/bin/tofi-drun"
				"$mainMod, X, pseudo," # dwindle
				"$mainMod, J, togglesplit" # dwindle
				"$mainMod, F, exec, librewolf"
				"$mainMod, G, fullscreen"
				"$mainMod, B, exec, flatpak run org.prismlauncher.PrismLauncher"
				"$mainMod, L, exec, ${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x10 --effect-vignette 0.5:0.5 --ring-color 00000000 --key-hl-color a6e3a1ff --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.2"
				", print, exec, screenshot"
				"SHIFT, print, exec, grim - | swappy -f -"
				"$mainMod, A, exec, flatpak run org.prismlauncher.PrismLauncher -l \"Additive(1)\""
				"$mainMod, S, exec, flatpak run org.prismlauncher.PrismLauncher -l \"SkyClient\""
				"$mainMod, P, exec, nwg-displays"
				"$mainMod, D, exec, qutebrowser"
		
				# brightness
				", xf86monbrightnessup, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness=raise"
				", xf86monbrightnessdown, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness=lower"

				# volume
				", xf86audioraisevolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume=raise"
				", xf86audiolowervolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume=lower"
				", xf86audiomute, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume=mute-toggle"

		
				# Move focus with mainMod + arrow keys
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"

				# Switch workspaces with mainMod + [0-9]
				"$mainMod, 1, workspace, 1"
				"$mainMod, 2, workspace, 2"
				"$mainMod, 3, workspace, 3"
				"$mainMod, 4, workspace, 4"
				"$mainMod, 5, workspace, 5"
				"$mainMod, 6, workspace, 6"
				"$mainMod, 7, workspace, 7"
				"$mainMod, 8, workspace, 8"
				"$mainMod, 9, workspace, 9"
				"$mainMod, 0, workspace, 10"

				# Move active window to a workspace with mainMod + SHIFT + [0-9]
				"$mainMod SHIFT, 1, movetoworkspace, 1"
				"$mainMod SHIFT, 2, movetoworkspace, 2"
				"$mainMod SHIFT, 3, movetoworkspace, 3"
				"$mainMod SHIFT, 4, movetoworkspace, 4"
				"$mainMod SHIFT, 5, movetoworkspace, 5"
				"$mainMod SHIFT, 6, movetoworkspace, 6"
				"$mainMod SHIFT, 7, movetoworkspace, 7"
				"$mainMod SHIFT, 8, movetoworkspace, 8"
				"$mainMod SHIFT, 9, movetoworkspace, 9"
				"$mainMod SHIFT, 0, movetoworkspace, 10"

				# Scroll through existing workspaces with mainMod + scroll
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"

				# hycov 
				"ALT, TAB, hycov:toggleoverview"
			];

			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
		};

		extraConfig = ''
			plugin {
				hycov {
					enable_hotarea = 0
					enable_alt_release_exit = 1
					alt_toggle_auto_next = 1
				}
			}
		'';
	};
}
