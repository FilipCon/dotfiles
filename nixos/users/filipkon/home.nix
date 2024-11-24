{ pkgs, ... }:

{
  imports = [ ../common.nix ];

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

  home.packages = with pkgs; [
    signal-desktop

    # dropbox client
    maestral
    maestral-gui

    # java lsp
    jdt-language-server

    # # python
    # python3
    # python311Packages.python-lsp-server
    # python311Packages.ipython
    # jupyter

    # common lisp
    sbcl

    # containers
    # podman-compose

    # latex
    texlive.combined.scheme-full

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
}
