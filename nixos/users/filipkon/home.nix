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

    # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true;
      # `gnome-extensions list` for a list
      enabled-extensions = [
        # "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        # "dash-to-panel@jderose9.github.com"
        # "sound-output-device-chooser@kgshank.net"
        # "space-bar@luchrioh"
      ];
      favorite-apps = [
        # "firefox.desktop"
        # "code.desktop"
        # "org.gnome.Terminal.desktop"
        # "spotify.desktop"
        # "virt-manager.desktop"
        # "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      # color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
    # `gsettings get org.gnome.shell.extensions.user-theme name`
    # "org/gnome/shell/extensions/user-theme" = {
    #   name = "palenight";
    # };
    # "org/gnome/desktop/wm/preferences" = {
    #   workspace-names = [ "Main" ];
    #   button-layout = "appmenu:minimize,maximize,close";
    # };
    # "org/gnome/desktop/background" = {
    #   picture-uri = "file://${./saturn.jpg}";
    #   picture-uri-dark = "file://${./saturn.jpg}";
    # };
    # "org/gnome/desktop/screensaver" = {
    #   picture-uri = "file://${./saturn.jpg}";
    #   primary-color = "#3465a4";
    #   secondary-color = "#000000";
    # };
  };

  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.dash-to-panel

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

    # # python
    # python3
    # python311Packages.python-lsp-server
    # python311Packages.ipython
    # jupyter

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
