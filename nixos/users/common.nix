{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
          '';
  };

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
    "org/gnome/calendar" = {
      show-week-numbers = true;
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

    # communication
    thunderbird
    slack

    # clojure
    clojure babashka clj-kondo clojure-lsp leiningen
    openjdk17
    nodejs
    visualvm

    # sql
    dbeaver-bin
    postgresql sqlite
    sqlfluff                  # sql linter

    # latex
    texlive.combined.scheme-full

    # docker ls
    dockerfile-language-server-nodejs
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
