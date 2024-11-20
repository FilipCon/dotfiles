{ pkgs, ... }:

{
  home.username = "lifecheq";
  home.homeDirectory = "/home/lifecheq";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
          '';
  };

  home.packages =  with pkgs; [
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

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
