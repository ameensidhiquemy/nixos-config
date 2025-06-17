# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.gnome.gnome-browser-connector.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ameen = {
    isNormalUser = true;
    description = "ameen";
    extraGroups = [ "networkmanager" "wheel" "video"];
    packages = with pkgs; [
    #  thunderbird
    
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    gnome-system-monitor
    nautilus
    dconf-editor


    
    vivaldi
    logseq
    albert
    copyq
    fsearch
    sublime
    mpv
    peazip
    obsidian
    anytype
    code-cursor
    vscode
    rar
    yandex-music

    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    
    ffmpeg
    mpv
    epiphany
    discord
    flatpak
    git
    
    



  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  
  #CUSTOM MINE START
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  #nixpkgs.config.firefox.enableGnomeExtensions = true;
  
  services.gnome.gnome-keyring.enable = true;
  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  
programs.light.enable = true;


security.polkit.enable = true;

  programs.ssh.extraConfig = ''
  Host github.com
      HostName github.com
      User git
      IdentitiesOnly yes
'';


  # >>> START OF CHANGES FOR ROOT LOGIN <<<

  # CRITICAL SECURITY WARNING: Allowing direct root graphical login is EXTREMELY DANGEROUS.
  # Do not do this on any system that is exposed to untrusted users or networks.

  # 1. Enable root login for GDM
  # This often involves overriding GDM's default configuration which prevents root login.
  # GDM's configuration is managed by NixOS, and we need to modify the settings that
  # prevent root from logging in graphically.
  # The `AllowRoot` setting in /etc/gdm/custom.conf (or similar) needs to be set to true.
  # NixOS's declarative way to do this is via `services.xserver.displayManager.gdm.extraConfig`.
environment.etc."gdm/custom.conf".text = pkgs.lib.mkForce ''
  # GDM configuration for root login (Added by NixOS configuration)
  [daemon]
  AllowRoot=true

  [security]
  DisallowTCP=true
'';

  # 2. Set a password for the root user if you haven't already.
  # You'll need to know the root password to log in.
  # If you don't have one, NixOS won't set it by default.
  # You can set it *after* the rebuild using `sudo passwd root`.
  # Or, if you want to set it declaratively (less common for root, more for initial setup):
  #users.users.root.initialHashedPassword = "0110"; # REPLACE THIS
  # To generate a hash: `nix-shell -p mkpasswd --run 'mkpasswd -m sha-512'` and enter your password.
  # Then copy the output into the quotes.
  # If you omit this, you must run `sudo passwd root` from your 'ameen' user after `nixos-rebuild switch`.

  # >>> END OF CHANGES FOR ROOT LOGIN <<<

}


