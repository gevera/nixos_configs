# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan
       <nixos-hardware/lenovo/thinkpad/t420>
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.plymouth.enable = true;

  networking.hostName = "thinkpad"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };
  
  # System Fonts
  fonts.fonts = with pkgs; [
   cm_unicode
   noto-fonts
   noto-fonts-cjk
   noto-fonts-emoji
   liberation_ttf
   ibm-plex
   montserrat
   fira-code
   fira-code-symbols
   mplus-outline-fonts
   dina-font
   open-sans
   overpass
   raleway
   ubuntu_font_family
  ];

  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";

  # Allow non-free packages to be installed
  nixpkgs.config.allowUnfree = true;
  
  # Allow NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  swapDevices = [ { 
      device = "/dev/sda2"; 
      size = 8024; # in MB 
  } ];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # command line tools
    tmux
    vim
    git
    wget
    curl
    mc
    ranger
    htop
    mutt
    screenfetch
    links
    p7zip

    # Utils
    xsel

    # minimal
    surf
    terminator

    # Office
    libreoffice
    focuswriter
    ghostwriter
    simplenote
    gnome-latex
    calibre

    # Imgae Manipulation
    inkscape
    gimp

    # Communication
    #claws-mail
    gnome3.geary
    tdesktop
    skypeforlinux
    zoom-us
    discord # viber rambox

    # development
    nodejs-12_x
    yarn
    postman
    insomnia
    robo3t
    # mongodb-compass # doesnt work
    dbeaver
    # pgadmin # doesnt work
    # pgmanage
    zeal
    # data base
    # mongodb-4_0 # doesnt work

    # gnome
    gnome3.gnome-tweaks # shows up in apps after reboot
    gnome3.pomodoro

    # project management
    elementary-planner

    # icons themes
    deepin.deepin-icon-theme
    papirus-icon-theme
    numix-icon-theme
    arc-icon-theme
    flat-remix-icon-theme
    pantheon.elementary-icon-theme

    # gtk themes
    deepin.deepin-gtk-theme
    yaru-theme
    sierra-gtk-theme
    mojave-gtk-theme
 
    # browser
    google-chrome # shows up in apps after reboot
    firefox

    # Downloads
    transmission-gtk
    nicotine-plus

    # Media
     # shortwave # only in unstable
    audacious
    vlc

    # IDE
    vscode # shows up in apps after reboot
    xfce.mousepad

    # npm packages
    nodePackages.typescript
    nodePackages.speed-test
    nodePackages.nodemon
    nodePackages.json-server
    nodePackages.http-server
    nodePackages.vue-cli
        # localtunnel
  ];

  # MongoDB
  services.mongodb.enable = true;
  
  
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.0.2u" ];
  
  
  # For thinkpad
  services.tlp.enable = true;

  # Battery power management
  services.upower.enable = true;
 
  # Fingerprint settings
  services.fprintd.enable = true;
  # security.pam.services.login.fprintAuth = true; 

  # Bluetooth seetings
  hardware.bluetooth.enable = true;
  hardware.bluetooth.extraConfig = " [General]Enable=Source,Sink,Media,Socket ";
  services.blueman.enable = true;
  

  # VirtualBox setup
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "codenow" ];
 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 3000 5000 27017 ];
  networking.firewall.allowedUDPPorts = [ 8080 3000 5000 27017 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome3.enable = true;  

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable Fish instead of Bash as a default shell
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.codenow = {
    shell = pkgs.fish;
    isNormalUser = true;
    home = "/home/codenow";
    description = "Code Now";
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

# ====================REMINDERS===================== #  

## find a npm available package -> e.g. typescript is the term
## nix-env -qaPA 'nixos.nodePackages' | grep -i typescript

## edit file and add packages and the rest of config
## sudo vim /etc/nixos/configuration.nix

## delete previous versions
## sudo nix-collect-garbage -d

## update the changed config 
## sudo nixos-rebuild switch

## sudo apt update
## sudo nix-channel --update

## sudo apt-get upgrade
## sudo nixos-rebuild switch

## To add a package from unstable
# nix-env -f https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz -iA deno

}

