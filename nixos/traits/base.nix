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
      LC_TIME = "en_US.UTF-8";
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
      direnv
      nix-direnv
      jq
      graphviz
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
