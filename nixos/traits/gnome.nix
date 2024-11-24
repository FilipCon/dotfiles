{ config, pkgs, lib, ... }:

{
  config = {
    # use xkb outside X11
    console.useXkbConfig = true;

    # NOTE Run the following in the terminal to reset the settings after nixos-rebuilt
    # gsettings reset org.gnome.desktop.input-sources xkb-options
    # gsettings reset org.gnome.desktop.input-sources sources
    services.xserver = {
      enable = true; # Enable the X11 windowing system.
      xkb.layout = "us,gr";
      exportConfiguration = true; # link /usr/share/X11/ properly
      xkb.options = "caps:ctrl_modifier, grp:alt_space_toggle";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs; [
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

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-characters
    ];

    services.gnome.gnome-keyring.enable = true;

    programs.dconf.enable = true;
  };
}
