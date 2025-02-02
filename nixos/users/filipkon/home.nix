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
    # dropbox client
    maestral
    maestral-gui

    jdt-language-server         # java lsp

    # nix
    alejandra                   # nix formatter
    nix-tree                    # dependency graphs of Nix derivations
    nil                         # nix lsp


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

    # media
    vlc                         # media player
    oculante                    # image viewer
    qbittorrent                 # torrent client
    fiji     # image processing

    # k8s
    minikube
    kubectl
    kubectx
    kubernetes-helm

    # ci/cd
    # config.nur.repos.dagger.dagger

    # investments
    portfolio
    wealthfolio

    # vpn
    protonvpn-gui

    # games
    pokemmo-installer
  ];
}
