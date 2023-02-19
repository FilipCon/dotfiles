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
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-f9a78d3d-284b-45f5-a4d7-27ffab4b2f79".device = "/dev/disk/by-uuid/f9a78d3d-284b-45f5-a4d7-27ffab4b2f79";
  boot.initrd.luks.devices."luks-f9a78d3d-284b-45f5-a4d7-27ffab4b2f79".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    layout = "us, gr";
    exportConfiguration = true; # link /usr/share/X11/ properly
    # xkbVariant = "gr";
    xkbOptions = "caps:ctrl_modifier, grp:alt_space_toggle";
  };


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;



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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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
    description = "Filip Konstantinos";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      brave
      librewolf
      thunderbird

      signal-desktop
      dropbox

      clojure babashka clj-kondo
      openjdk17
      nodejs
      docker
      postgresql sqlite
      sbcl
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [ epkgs.vterm
                                                          epkgs.pdf-tools ]))
    wget
    git
    ripgrep
    htop
    ntfs3g
    fzf
  ];

  # Specify nerd-fonts to install
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" "DejaVuSansMono"]; })
  ];

  fonts.fontDir.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "22.11"; # Did you read the comment?

}
