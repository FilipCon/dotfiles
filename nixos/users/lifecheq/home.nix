{ pkgs, ... }:

{
  home.username = "lifecheq";
  home.homeDirectory = "/home/lifecheq";

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
    sqlfluff
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
