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

  # --- MODIFIED: Enable Plasma and use SDDM as the Display Manager ---
  services.xserver.displayManager.sddm.enable = true;

  services.desktopManager = {
    cosmic.enable = true;
    plasma6.enable = true; # Added KDE Plasma
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.gnome.gnome-browser-connector.enable = true; # This is fine to keep

  # --- MODIFIED: Added KDE portal for better integration ---
  xdg.portal = {
    enable = true;
    extraPortals = [
#       pkgs.xdg-desktop-portal-gtk
#       pkgs.xdg-desktop-portal-gnome
    ];
    config.common.default = [ "*" ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

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
  programs.kdeconnect.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
#   programs.niri.enable = true;

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

    # Wayland/Sway specific tools (can be kept)
    grim
    slurp
    wl-clipboard
    mako

    # CLI tools
    ffmpeg
    ripgrep
    fd

    # COSMIC Packages (Good to keep for the COSMIC session)
    cosmic-session
    cosmic-settings
    cosmic-launcher
    cosmic-notifications
    cosmic-panel
    
    # --- ADDED: Essential packages for a good KDE Plasma experience ---
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.spectacle
    kdePackages.ark
    kdePackages.kate
    kdePackages.xdg-desktop-portal-kde # Added for KDE
    plasma-panel-colorizer
    plasma-panel-spacer-extended


#       kdePackages.krecorder
#       kdePackages.kweather
#       kdePackages.kcharselect
#       kdePackages.filelight
#       kdePackages.kcalc
#       kdePackages.kclock
#       kdePackages.kholidays
#       kdePackages.akonadi-calendar
#       kdePackages.libkdepim
#       kdePackages.kdepim-addons
#       kdePackages.kdepim-runtime
#       kdePackages.kcontacts
#       libqalculate
#       qalculate-qt

#       floorp
      kdePackages.plasma-browser-integration

#       kdePackages.zanshin
      kdePackages.korganizer
#       kdePackages.merkuro
#       kdePackages.francis

#       lldb
#       kdePackages.kompare
#       kdePackages.kdevelop
#       kdePackages.kcachegrind
#       gcc
#       gdb
#       clang-tools
#       bash-language-server
#       nixd
#       nixfmt
#       marksman
#       kdePackages.markdownpart
#       lua
#       lua-language-server
#       cppcheck
#       nixos-shell

      kdePackages.qtwebengine
      kdePackages.qtlocation
      kdePackages.ksystemstats # needed for the resource widgets
#       aspell # needed for spell checking
#       aspellDicts.en
#       aspellDicts.hu
#       kdePackages.qtmultimedia
      kdePackages.karousel

#       gimp
#       inkscape
#       kdePackages.kdenlive
#
#       libreoffice
#       pandoc
#       texliveFull

#       beeper

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

  # --- REMOVED: Deleted the insecure and non-functional root login configuration ---

  # CUSTOM MINE START
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. It's recommended to leave this value as is.
  system.stateVersion = "25.05"; # Did you read the comment?
}
