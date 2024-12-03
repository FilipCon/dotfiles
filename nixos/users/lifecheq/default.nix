{ lib, pkgs, ... }:

{
  config = {
    home-manager.users.lifecheq = ./home.nix;
    users.users.lifecheq = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
    };
  };
}
