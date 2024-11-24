{ lib, pkgs, ... }:

{
  config = {
    home-manager.users.filipkon = ./home.nix;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.filipkon = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      packages = with pkgs; [
        steam
      ];
    };
  };
}
