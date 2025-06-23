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

  # --- Display and Desktop Managers ---
  # Use SDDM as the single display manager.
  services.xserver.displayManager.sddm.enable = true;
  hardware.bluetooth.enable = true;
  # Enable the desktop environments.
  services.desktopManager.cosmic.enable = true;

  # FIXED: Use the new top-level option for Plasma 6.
  services.desktopManager.plasma6.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.gnome.gnome-browser-connector.enable = true;

  # FIXED: Updated the package name for the KDE portal.
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.kdePackages.xdg-desktop-portal-kde # Corrected package name
    ];
    config.common.default = [ "*" ];
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # Define a user account.
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

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # General Applications
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
    solaar
    epiphany
    discord
    flatpak
    git
    emacs

    # Wayland/Sway specific tools
    grim
    slurp
    wl-clipboard
    mako

    # CLI tools
    ffmpeg
    ripgrep
    fd

    # COSMIC Packages
    cosmic-session
    cosmic-settings
    cosmic-launcher
    cosmic-notifications
    cosmic-panel

    # Essential KDE Packages for a good experience
    kdePackages.dolphin # File Manager
    kdePackages.konsole # Terminal
    kdePackages.spectacle # Screenshot Tool
    kdePackages.ark # Archiving Tool
    kdePackages.kate # Text Editor
  ];

  services.udev.packages = with pkgs; [
    solaar
  ];

  # Enable GNOME Keyring (useful across desktops)
  services.gnome.gnome-keyring.enable = true;

  programs.light.enable = true;
  security.polkit.enable = true;

  # Custom SSH Config
  programs.ssh.extraConfig = ''
    Host github.com
      HostName github.com
      User git
      IdentitiesOnly yes
  '';

  # --- REMOVED: Insecure and non-functional root login configuration ---

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
