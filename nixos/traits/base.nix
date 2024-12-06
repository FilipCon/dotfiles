{ config, pkgs, lib, ... }:

{
  config = {

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
      LC_TIME = "en_DK.UTF-8";  # monday as first day of the week
    };

    programs.fish.enable = true;
    programs.steam.enable = true;

    # # Thunar file manager
    # programs.thunar.enable = true;
    # programs.xfconf.enable = true;
    # programs.thunar.plugins = with pkgs.xfce; [
    #   thunar-archive-plugin
    #   thunar-volman
    #   thunar-dropbox-plugin
    # ];
    # services.gvfs.enable = true; # Mount, trash, and other functionalities
    # services.tumbler.enable = true; # Thumbnail support for images

    # enable docker
    # virtualisation.podman.enable = true;
    # virtualisation.podman.dockerCompat = true;
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    system.activationScripts.binbash = {
      deps = [ "binsh" ];
      text = ''
         ln -sf /bin/sh /bin/bash
    '';
    };

    # Allow unfree and unsupported packages
    nixpkgs.config.allowUnfree = true;
    # nixpkgs.config.allowUnsupportedSystem = true;

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      ((emacsPackagesFor emacs29).emacsWithPackages (epkgs: [ epkgs.vterm
                                                              epkgs.pdf-tools
                                                              epkgs.jinx
                                                              epkgs.zprint-format
                                                              epkgs.zprint-mode]))
      
      pciutils
      wget
      git
      git-credential-manager
      ripgrep
      htop
      nvtopPackages.full
      ntfs3g
      fzf
      atool
      unzip
      ispell
      lshw
      direnv
      nix-direnv
      jq
      graphviz
      gcc
      tealdeer
      bat
      lm_sensors
      gnumake
      dmidecode
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "SourceCodePro" "DejaVuSansMono"]; })
    ];

    fonts.fontDir.enable = true;

    # # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # use flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "22.11"; # DONT change
  };
}
