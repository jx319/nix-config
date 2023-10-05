{ inputs, lib, config, pkgs, ... }: {
  wayland.windowManager.hyprland = {
  	enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.hyprland;

	extraConfig = ''
		# See https://wiki.hyprland.org/Configuring/Monitors/
		source = ~/.config/hypr/monitors.conf
		source = ~/.config/hypr/workspaces.conf


		# See https://wiki.hyprland.org/Configuring/Keywords/ for more

		exec-once = swww init
		exec-once = sww img ~/nix-config/home/nix-wallpaper-catppuccin-mocha-green.png
		exec-once = dunst
		exec-once = eww daemon
		exec-once = eww open bar
		 
		# Source a file (multi-file configs)
		source = ~/nix-config/home/hyprland/catppuccin_mocha.conf

		# Some default env vars.
		env = XCURSOR_SIZE,24
		env = QT_QPA_PLATFORMTHEME,qt5ct

		# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
		input {		
		    kb_layout = de
		    kb_variant =
		    kb_model =
		    kb_options =
		    kb_rules =

		    follow_mouse = 1
		    accel_profile = flat

		    touchpad {
		        natural_scroll = true
		    }

		    sensitivity = 0.3 # -1.0 - 1.0, 0 means no modification.
		}

		general {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more

		    gaps_in = 5
		    gaps_out = 20
		    border_size = 2
		    col.active_border = $green
		    col.inactive_border = $surface1
		    layout = dwindle
		}

		decoration {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more

		    rounding = 10
	      drop_shadow = true
		    shadow_range = 4
		    shadow_render_power = 3
		    col.shadow = rgba(1a1a1aee)
		}

		animations {
		    enabled = true

		    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

		    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
											
		    animation = windows, 1, 7, myBezier, slide
		    animation = windowsOut, 1, 7, myBezier, slide
		    animation = border, 1, 10, default
		    animation = borderangle, 1, 8, default
		    animation = fade, 1, 7, default
		    animation = workspaces, 1, 6, default
		}

		dwindle {
		    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		    pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
		    preserve_split = true # you probably want this
		}

		master {
		    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
		    new_is_master = true
		}

		gestures {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more
		    workspace_swipe = true
		}
		misc {
			disable_hyprland_logo = true
		}

		# Example per-device config
		# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
		device:epic-mouse-v1 {
		    sensitivity = -0.5
		}

		# Example windowrule v1
		# windowrule = float, ^(kitty)$
		# Example windowrule v2
		# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
		windowrulev2 = float,class:(prismlauncher)
		windowrulev2 = float,class:(polkit-kde-authentication-agent-1)
		windowrulev2 = float,class:(nwg-displays)
		# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


		# See https://wiki.hyprland.org/Configuring/Keywords/ for more
		$mainMod = SUPER

		# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
		bind = $mainMod, Q, exec, alacritty
		bind = $mainMod, C, killactive,
		bind = $mainMod, M, exit,
		bind = $mainMod, E, exec, thunar
		bind = $mainMod, V, togglefloating,
		bind = $mainMod, R, exec, wofi --show drun
		bind = $mainMod, X, pseudo, # dwindle
		bind = $mainMod, J, togglesplit, # dwindle
		bind = $mainMod, F, exec, librewolf
		bind = $mainMod, G, fullscreen
		bind = $mainMod, B, exec, flatpak run org.prismlauncher.PrismLauncher
		bind = $mainMod, L, exec, swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x10 --effect-vignette 0.5:0.5 --ring-color 00000000 --key-hl-color a6e3a1ff --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.2
		bind = , print, exec, screenshot
		bind = SHIFT, print, exec, grim - | swappy -f -
		bind = $mainMod, A, exec, flatpak run org.prismlauncher.PrismLauncher -l "Adrenaline"
		bind = $mainMod, S, exec, flatpak run org.prismlauncher.PrismLauncher -l "SkyClient"

		bind = $mainMod, P, exec, nwg-displays
		
		# brightness
		bind = , xf86monbrightnessup, exec, swayosd --brightness=raise
		bind = , xf86monbrightnessdown, exec, swayosd --brightness=lower

		# volume
		bind = , xf86audioraisevolume, exec, swayosd --output-volume=raise
		bind = , xf86audiolowervolume, exec, swayosd --output-volume=lower
		bind = , xf86audiomute, exec, swayosd --output-volume=mute-toggle
		
		# Move focus with mainMod + arrow keys
		bind = $mainMod, left, movefocus, l
		bind = $mainMod, right, movefocus, r
		bind = $mainMod, up, movefocus, u
		bind = $mainMod, down, movefocus, d

		# Switch workspaces with mainMod + [0-9]
		bind = $mainMod, 1, workspace, 1
		bind = $mainMod, 2, workspace, 2
		bind = $mainMod, 3, workspace, 3
		bind = $mainMod, 4, workspace, 4
		bind = $mainMod, 5, workspace, 5
		bind = $mainMod, 6, workspace, 6
		bind = $mainMod, 7, workspace, 7
		bind = $mainMod, 8, workspace, 8
		bind = $mainMod, 9, workspace, 9
		bind = $mainMod, 0, workspace, 10

		# Move active window to a workspace with mainMod + SHIFT + [0-9]
		bind = $mainMod SHIFT, 1, movetoworkspace, 1
		bind = $mainMod SHIFT, 2, movetoworkspace, 2
		bind = $mainMod SHIFT, 3, movetoworkspace, 3
		bind = $mainMod SHIFT, 4, movetoworkspace, 4
		bind = $mainMod SHIFT, 5, movetoworkspace, 5
		bind = $mainMod SHIFT, 6, movetoworkspace, 6
		bind = $mainMod SHIFT, 7, movetoworkspace, 7
		bind = $mainMod SHIFT, 8, movetoworkspace, 8
		bind = $mainMod SHIFT, 9, movetoworkspace, 9
		bind = $mainMod SHIFT, 0, movetoworkspace, 10

		# Scroll through existing workspaces with mainMod + scroll
		bind = $mainMod, mouse_down, workspace, e+1
		bind = $mainMod, mouse_up, workspace, e-1

		# Move/resize windows with mainMod + LMB/RMB and dragging
		bindm = $mainMod, mouse:272, movewindow
		bindm = $mainMod, mouse:273, resizewindow

		# exec-once = bash ~/.config/hypr/start.sh

	'';
  };
}
