{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [
      inputs.disko.nixosModules.disko
      ./disko.nix
      ./hardware-configuration.nix
    ];

  boot = {
    initrd = {
      kernelModules = [ "zfs" ];
      supportedFilesystems = [ "zfs" ];
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r zroot/root@blank
      '';
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [
      "nohibernate"
    ];
    supportedFilesystems = [ "zfs" ];
    zfs = {
      enabled = true;
    };
  };
  
  networking = {
  	hostName = "nixos";
  };
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  services = {   
    udev.packages = [
      pkgs.swayosd
    ];
    xserver = {
      enable = true;
    };
    printing = {
      enable = true;
    };
     
    flatpak.enable = true;
    gvfs.enable = true;
    blueman.enable = true;

    # fwupd = {
    #   enable = true;
    # };
  };
   
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  
  programs = {
    zsh.enable = true;
    gamemode.enable = true;
    dconf.enable = true;
    xfconf.enable = true;

    fuse = {
      mountMax = 32767;
      userAllowOther = true;
    };
  };
  
  users.users.jonas = {
    isNormalUser = true;
    extraGroups = [ "input" "libvirtd" "networkmanager" "plugdev" "video" "wheel" ];
    hashedPassword = "$y$j9T$AD.qNIIN3zQDnCd8ePuCS.$H7Elgh4JCLOLcXtB/Qx0Fu2fHemn4q.t6u4kDBMG3H1";
    shell = pkgs.zsh;
  };
  
  environment = {
    systemPackages = with pkgs; [
      firefox
      librewolf
      neofetch
      libnotify
      killall
      wl-clipboard
      gimp
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
      openrazer-daemon
    ];
    sessionVariables = {
    	NIXOS_OZONE_WL = "1";
      EDITOR = "hx";
    };
  };

  xdg.portal = {
  	enable = true;
	  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
    
  hardware = {
  	opengl = {
      enable = true;
      extraPackages = with pkgs; [
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
