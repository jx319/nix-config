{ pkgs, inputs, ... }:

#let
#  swayConfig = pkgs.writeText "greetd-sway-config" ''
#    
#    #exec "${pkgs.greetd.regreet}/bin/regreet; swaymsg exit"
#    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
#    bindsym Mod4+shift+e exec swaynag \
#      -t warning \
#      -m 'What do you want to do?' \
#      -b 'Poweroff' 'systemctl poweroff' \
#      -b 'Reboot' 'systemctl reboot'
#  '';
#in
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      
      efi.canTouchEfiVariables = true;
    };
    #plymouth.enable = true; doesn't work with Linux 6.6 for some reason
    kernelPackages = pkgs.linuxPackages_latest;
  };

  console = {
      colors = [
      "1e1e2e" # base
      "f38ba8" # red
      "a6e3a1" # green
      "f9e2af" # yellow
      "89b4fa" # blue
      "f5c2e7" # pink
      "94e2d5" # teal
      "bac2de" # subtext1
      "585b70" # surface2
      "f38ba8" # red
      "a6e3a1" # green
      "f9e2af" # yellow
      "89b4fa" # blue
      "f5c2e7" # pink
      "94e2d5" # teal
      "a6adc8" # subtext0 
    ];
    earlySetup = true;
    keyMap = "de";
  };
  
  networking = {
  	hostName = "nixos";
  	networkmanager = {
		  enable = true;
	  };  
  };
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      
      substituters = [
        "https://hyprland.cachix.org"
        "https://helix.cachix.org"
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://ags.cachix.org"
        "nix-community.cachix.org"
      ];
      
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  
  services = {   
    udev.packages = [
      pkgs.swayosd
    ];

    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${import ./catppuccin-sddm.nix { inherit pkgs; }}";
      };
      desktopManager.plasma5 = {
        enable = true;
      };
    };
    
    printing = {
      enable = true;
    };
        
    flatpak.enable = true;
    
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };

    blueman.enable = true;

    fwupd = {
      enable = true;
    };
  };
 
  
  #services.greetd = {
  #  enable = true;
  #  settings = {
  #    default_session = {
  #      #command = "${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --config ${swayConfig}";
  #      command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t li";
  #      user = "greeter";
  #    };
  #  };
  #};
  #programs.regreet = {
  #  enable = true;
  #  settings = {
  #    background = {
  #      path = ../home/hyprland/nix-black-4k.png;
  #    };
  #    GTK = {
  #      cursor_theme_name = "Catppuccin-Mocha-Green-Cursors";
  #      font_name = "JetBrainsMono Nerd Font Propo";
  #      icon_theme_name = "Papirus-Dark";
  #      theme_name = "Catppuccin-Mocha-Standard-Green-Dark";
  #    };
  #  };
  #};
  
  security = {
    rtkit.enable = true;

    polkit.enable = true;
  };
  
  programs = {
    zsh.enable = true;
    
    gamemode.enable = true;
    
    hyprland = {
      enable = true;
	    xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    
    wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wayfire-plugins-extra
        wf-shell
      ];
    };

    sway = {
      enable = true;
      package = pkgs.swayfx;
    };

    dconf.enable = true;
  };
  
  users.users.jonas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" "plugdev" ];
    packages = with pkgs; [
      python3
      tree
      ranger
      ktorrent
      libsForQt5.kmenuedit
      hyprpicker
      vitetris
      glxinfo
      inputs.nwg-displays.packages.${pkgs.system}.default
      distrobox
      mpv
      polychromatic
      pods
      packwiz
    ];
    shell = pkgs.zsh;
  };
  
  environment = {
    systemPackages = with pkgs; [
      curl
      firefox
      librewolf
      neofetch
      btop
      wofi
      dunst
      libnotify
      killall
      grim
      slurp
      swaylock-effects
      wlogout
      swappy
      wl-clipboard
      imagemagick
      gimp
      (import ./scripts/screenshot.nix { inherit pkgs; })
      brightnessctl
      virt-manager
      qemu
      libsForQt5.polkit-kde-agent
      wl-clipboard
      socat
      jq
      alacritty
      xfce.thunar
      xfce.thunar-volman
      pamixer
      obs-studio
      signal-desktop
      acpi
      libreoffice
      (catppuccin-gtk.override {
  		    accents = [ "green" ];
          size = "standard";
  		    variant = "mocha";
    	})
      catppuccin-cursors.mochaGreen
      (catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "green";
      })
      libsForQt5.qt5.qtsvg
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
      openrazer-daemon
    ];
    sessionVariables = {
    	NIXOS_OZONE_WL = "1";
      EDITOR = "hx";
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
  };
  
  xdg.portal = {
  	enable = true;
	  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
    
  
  hardware = {
  	opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    bluetooth.enable = true;

    openrazer = {
      enable = true;
      users = [ "jonas" ];
    };
    
  };
  
  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authenticationcation-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
  fonts.packages = with pkgs; [
  	(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  
  networking.firewall = { 
    enable = false;  
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
  };
 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
