{ inputs, pkgs, ... }: 

{
  wayland.windowManager.hyprland = 
	let
		lockscreen = pkgs.writeShellScript "lockscreen" ''
			${pkgs.swaylock-effects}/bin/swaylock \
								--screenshots \
								--clock \
								\
								--indicator \
								--indicator-radius 100 \
								--indicator-thickness 7 \
								\
								--effect-blur 7x10 \
								--effect-vignette 0.5:0.5 \
								\
								--ring-color 00000000 \
								--key-hl-color a6e3a1ff \
								--text-color a6e3a1ff \
								--line-color 00000000 \
								\
								--inside-color 00000088 \
								--inside-ver-color 89b4faff \
								--inside-wrong-color ec88a6ff \
								\
								--separator-color 00000000 \
								--fade-in 0.2 \
								--font "JetBrainsMono Nerd Font"
		'';
	in
	{
  	enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.hyprland;

		plugins = [ ];

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
				"${inputs.ags.packages.${pkgs.system}.ags}/bin/ags"
				#"${pkgs.hyprpaper}/bin/hyprpaper"
				# "${pkgs.dunst}/bin/dunst"
				#"${inputs.nixpkgs-wayland.packages.${pkgs.system}.eww-wayland}/bin/eww daemon"
				#"${inputs.nixpkgs-wayland.packages.${pkgs.system}.eww-wayland}/bin/eww open bar"
				"${pkgs.swayosd}/bin/swayosd-server"
				"sleep 10; ${pkgs.networkmanagerapplet}/bin/nm-applet"
				"sleep 1; ${pkgs.blueman}/bin/blueman-applet"
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
			    gaps_out = 10;
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

					blur = {
						enabled = true;
						size = 5;
						special = true;
						popups = true;
					};
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
					no_gaps_when_only = true;
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
			windowrule = [ ];
			
			windowrulev2 = [
				"float,class:(prismlauncher)"
				"float,class:(xdg-desktop-portal-gtk)"
				"float,class:(polkit-kde-authentication-agent-1)"
				"float,class:(nwg-displays)"
				"float,class:(org.kde.kdeconnect.handler)"
				"float,class:(pavucontrol)"
				"float,class:(codium)"
			];

			layerrule = [
				"blur,powermenu"
				"blur,anyrun"
				"ignorezero,anyrun"
			];
			
			# keybinds
			"$mainMod" = "SUPER";

			bind = [
				"$mainMod, Q, exec, ${pkgs.alacritty}/bin/alacritty"
				"$mainMod, C, killactive"
				"$mainMod, M, exit"
				"$mainMod, E, exec, ${pkgs.xfce.thunar}/bin/thunar"
				"$mainMod, V, togglefloating"
				# "$mainMod, R, exec, ${pkgs.tofi}/bin/tofi-drun"
				"$mainMod, R, exec, ${inputs.anyrun.packages.${pkgs.system}.default}/bin/anyrun"
				"$mainMod, S, togglesplit" # dwindle
				"$mainMod, F, exec, ${pkgs.librewolf}/bin/librewolf"
				"$mainMod, G, fullscreen"
				"$mainMod, B, exec, flatpak run org.prismlauncher.PrismLauncher"
				"$mainMod, escape, exec, ${lockscreen}"
			
				'', print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -c 00000000 -b a6e3a1a0 -d -F 'JetBrainsMono Nerd Font')" - | ${pkgs.swappy}/bin/swappy -f -''
			
				"SHIFT, print, exec, ${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f -"
				
				"$mainMod, A, exec, flatpak run org.prismlauncher.PrismLauncher -l \"Additive(1)\""
				"$mainMod, P, exec, ${inputs.nwg-displays.packages.${pkgs.system}.default}/bin/nwg-displays"
				"$mainMod, D, exec, ${pkgs.qutebrowser}/bin/qutebrowser"
		
				# brightness
				", xf86monbrightnessup, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness=raise"
				", xf86monbrightnessdown, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness=lower"

				# volume
				", xf86audioraisevolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume=raise"
				", xf86audiolowervolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume=lower"
				", xf86audiomute, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume=mute-toggle"

				"$mainMod, H, movefocus, l"
				"$mainMod, J, movefocus, d"
				"$mainMod, K, movefocus, u"
				"$mainMod, L, movefocus, r"

				"$mainMod, left, movefocus, l"
				"$mainMod, down, movefocus, d"
				"$mainMod, up, movefocus, u"
				"$mainMod, right, movefocus, r"

				"$mainMod SHIFT, H, movewindow, l"
				"$mainMod SHIFT, J, movewindow, d"
				"$mainMod SHIFT, K, movewindow, u"
				"$mainMod SHIFT, L, movewindow, r"

				"$mainMod ALT, J, splitratio, -0.1"
				"$mainMod ALT, K, splitratio, 0.1"

				# hyprnome workspace switching
				"$mainMod, 1, exec, ${pkgs.hyprnome}/bin/hyprnome --previous"
				"$mainMod, 2, exec, ${pkgs.hyprnome}/bin/hyprnome"

				# move active window with hyprnome
				"$mainMod SHIFT, 1, exec, ${pkgs.hyprnome}/bin/hyprnome --move --previous"
				"$mainMod SHIFT, 2, exec, ${pkgs.hyprnome}/bin/hyprnome --move"
				
				# Scroll through existing workspaces with mainMod + scroll
				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"
			];

			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
		};

		extraConfig = '''';
	};
}
