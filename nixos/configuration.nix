{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-f9a78d3d-284b-45f5-a4d7-27ffab4b2f79".device = "/dev/disk/by-uuid/f9a78d3d-284b-45f5-a4d7-27ffab4b2f79";
  boot.initrd.luks.devices."luks-f9a78d3d-284b-45f5-a4d7-27ffab4b2f79".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # NOTE Run the following in the terminal to reset the settings after nixos-rebuilt
  # gsettings reset org.gnome.desktop.input-sources xkb-options
  # gsettings reset org.gnome.desktop.input-sources sources
  services.xserver = {
    enable = true;   # Enable the X11 windowing system.
    layout = "us,gr";
    exportConfiguration = true; # link /usr/share/X11/ properly
    xkbOptions = "caps:ctrl_modifier, grp:alt_space_toggle";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
  ]);

  programs.dconf.enable = true;

  # use xkb outside X11
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.tapping = true;
    touchpad.naturalScrolling = false;
    touchpad.disableWhileTyping = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.filipkon = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      brave
      firefox
      librewolf
      thunderbird

      signal-desktop

      dbeaver
      clojure babashka clj-kondo clojure-lsp
      openjdk17
      nodejs
      postgresql sqlite
      sqlfluff                  # sql linter
      sbcl

      texlive.combined.scheme-full
      ispell
    ];
  };

  # enable docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs29).emacsWithPackages (epkgs: [ epkgs.vterm
                                                            epkgs.pdf-tools ]))
    wget
    git
    ripgrep
    htop
    ntfs3g
    fzf
    atool
    unzip
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" "DejaVuSansMono"]; })
  ];

  fonts.fontDir.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # use flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
