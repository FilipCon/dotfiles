{ lib, pkgs, ... }:

{
  config = {
    home-manager.users.lifecheq = ./home.nix;
    users.users.lifecheq = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        # browsers
        brave
        chromium
        firefox

        # communication
        thunderbird
        slack

        ## programming

        # clojure
        clojure
        babashka
        clj-kondo
        clojure-lsp
        leiningen
        openjdk17
        nodejs
        visualvm

        # sql
        dbeaver-bin
        postgresql
        sqlfluff                  # sql linter
      ];
    };
  };
}
