{ inputs, pkgs, ... }: 

{
	imports = [
		./hyprlock.nix
	];
	
  wayland.windowManager.hyprland = 
	let	
		swww = "${inputs.nixpkgs-wayland.packages.${pkgs.system}.swww}/bin/swww";
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
		# https://github.com/LGFae/swww/blob/24cc0c34c3262bee688a21070c7e41e637c03d71/example_scripts/swww_randomize.sh
		swww_randomize = pkgs.writeShellScript "swww_randomize" ''
			# This script will randomly go through the files of a directory, setting it
			# up as the wallpaper at regular intervals
			#
			# NOTE: this script is in bash (not posix shell), because the RANDOM variable
			# we use is not defined in posix
			sleep 1
			# This controls (in seconds) when to switch to the next image
			INTERVAL=300

			while true; do
				find "$1" -type f \
					| while read -r img; do
						echo "$((RANDOM % 1000)):$img"
					done \
					| sort -n | cut -d':' -f2- \
					| while read -r img; do
						${swww} img --transition-type wipe --transition-angle 45 --transition-fps 60 --transition-step 2 "$img"
						sleep $INTERVAL
					done
			done
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
			exec-once = 
			[
				"hyprctl setcursor Catppuccin-Mocha-Green-Cursors 32"
				# "${pkgs.swaybg}/bin/swaybg -i ${./nix-black-4k.png}"
				"${inputs.ags.packages.${pkgs.system}.ags}/bin/ags"
				"${swww} init"
				"${swww_randomize} ${./wallpapers}"
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
					size = 10;
					special = true;
					popups = true;
				};
			};

			animations = {
		    enabled = true;

		    bezier = [
					"myBezier, 0.05, 0.9, 0.1, 1.05"
					"easeOutCirc, 0, 0.55, 0.45, 1"
					"easeOutExpoOvershoot, 0.16, 1, 0.3, 1.2"
				];
										
		    animation = [
					"windows, 1, 3, easeOutCirc, slide"
			    "layers, 1, 3, easeOutCirc, slide"
			    "border, 1, 10, default"
			    "borderangle, 1, 8, default"
			    "fade, 1, 5, default"
					"fadeLayers, 1, 5, default"
			    "workspaces, 1, 5, default"
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

				"noanim,swww"
				"noanim,hyprpicker"

				"animation fade,swayosd"
				"animation fade,selection" # grim screenshots slurp if the animation is too slow
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
				"$mainMod, S, togglesplit" # dwindle
				"$mainMod, F, exec, ${pkgs.librewolf}/bin/librewolf"
				"$mainMod, G, fullscreen"
				"$mainMod, B, exec, flatpak run org.prismlauncher.PrismLauncher"
				"$mainMod, escape, exec, ${inputs.hyprlock.packages.${pkgs.system}.hyprlock}/bin/hyprlock"
			
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

			bindr = [
				"SUPER, SUPER_L, exec, ${inputs.anyrun.packages.${pkgs.system}.default}/bin/anyrun"
			];

			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
		};

		extraConfig = '''';
	};

	home.packages = [
		inputs.nixpkgs-wayland.packages.${pkgs.system}.swww
	];
}
