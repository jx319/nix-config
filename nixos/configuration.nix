# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  services.udev.packages = [
    pkgs.swayosd
  ];
  
  networking = {
  	hostName = "nixos";
  	networkmanager = {
		  enable = true;
	  };  
  };
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
    
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # pipewire sound
  security.rtkit.enable = true;
  services = {
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
  };
  
  users.users.jonas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" ];
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
    ];
  };
  
  security.polkit.enable = true;
  
  environment.systemPackages = with pkgs; [
    curl
    firefox
    librewolf
    neofetch
    btop
    wofi
    swww
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
  ];

  programs.gamemode.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
  };

  
  xdg.portal = {
  	enable = true;
	  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
  programs.hyprland = {
  	enable = true;
	  xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://helix.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      ];
  };
  
  environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
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
  };
  services.flatpak.enable = true;
  programs.dconf.enable = true;
  
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
  	(nerdfonts.override { fonts = [ "JetBrainsMono" "SpaceMono" "RobotoMono" "Arimo" ]; })
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
