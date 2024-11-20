{ pkgs, ... }:

{
  home.username = "filipkon";
  home.homeDirectory = "/home/filipkon";

  programs.git = {
    enable = true;
    userName = "Konstantinos Filip";
    userEmail = "filipconstantinos@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.fish.enable = true;

  home.packages = with pkgs; [
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
    slack
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

    # torrent client
    qbittorrent

    # media player
    vlc

    # k8s
    minikube
    kubectl
    kubectx
    kubernetes-helm

    # ci/cd
    # config.nur.repos.dagger.dagger

    # image processing
    fiji
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
