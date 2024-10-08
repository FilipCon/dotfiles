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
    xkb.layout = "us,gr";
    exportConfiguration = true; # link /usr/share/X11/ properly
    xkb.options = "caps:ctrl_modifier, grp:alt_space_toggle";
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

  # environment.localBinInPath = true;

  programs.dconf.enable = true;

  # use xkb outside X11
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.samsung-unified-linux-driver ];
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Samsung_M2020";
        location = "Home";
        deviceUri = "usb://Samsung/M2020%20Series?serial=08HVB8GJ7F04Q2D";
        model = "samsung/M262x.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };

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
  services.libinput = {
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
      # browsers
      brave
      firefox
      # librewolf

      # dropbox client
      maestral
      maestral-gui

      # communication
      thunderbird
      signal-desktop

      # programming

      # clojure
      clojure babashka clj-kondo clojure-lsp leiningen
      openjdk17
      nodejs

      visualvm

      # java lsp
      jdt-language-server

      # python
      python3
      python311Packages.python-lsp-server
      python311Packages.ipython
      jupyter

      # sql
      dbeaver-bin
      postgresql sqlite
      sqlfluff                  # sql linter

      # common lisp
      sbcl

      # containers
      # podman-compose

      # latex
      texlive.combined.scheme-full

      # docker ls
      dockerfile-language-server-nodejs

      direnv

      # torrent client
      qbittorrent

      # media player
      vlc

      # k8s
      minikube
      kubectl
      kubectx
      kubernetes-helm
    ];
  };

  # enable docker
  # virtualisation.podman.enable = true;
  # virtualisation.podman.dockerCompat = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs29).emacsWithPackages (epkgs: [ epkgs.vterm
                                                            epkgs.pdf-tools
                                                            epkgs.jinx]))
    pciutils
    wget
    git
    ripgrep
    htop
    ntfs3g
    fzf
    atool
    unzip
    ispell
    psensor
    lshw
    config.nur.repos.dagger.dagger
  ];

  fonts.packages = with pkgs; [
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
