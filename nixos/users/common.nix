{ pkgs, lib, ... }:

let
  inherit (lib.gvariant) mkTuple mkUint32;
in
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
      last-selected-power-profile = "performance";
      # `gnome-extensions list` for a list
      enabled-extensions = [
        # "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "system-monitor-next@paradoxxx.zero.gmail.com"
        "trayIconsReloaded@selfmade.pl"
        "dash-to-dock@micxgx.gmail.com"
      ];
      favorite-apps = [
        "org.gnome.Console.desktop"
        # "thunar.desktop"
        "org.gnome.Nautilus.desktop"
        "brave-browser.desktop"
        # "emacs.desktop"
        "thunderbird.desktop"
        "slack.desktop"
      ];
    };
    "org/gnome/shell/extensions/system-monitor" = {
      icon-display = false;
      show-tooltip = true;
      disk-display = true;
      # gpu-display = true;
      # gpu-show-menu = true;
      thermal-display = true;
      thermal-style = "digit";
      thermal-sensor-label = "coretemp - Package id 0";
      fan-show-menu = false;
      disk-usage-style = "bar";
      net-speed-in-bits = true;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      multi-monitor = true;
      show-trash = false;
      show-mounts = false;
      show-show-apps-button = false;
      apply-custom-theme = true;
      custom-theme-shrink = false;
    };
    "org/gnome/desktop/interface" = {
      # color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
    "org/gnome/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };
    "org/gnome/desktop/background" = {
      # picture-uri = "file://${./saturn.jpg}";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
      primary-color = "#241f31";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      primary-color = "#241f31";
    };
    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-ac-type = "nothing";
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.dash-to-panel
    # gnomeExtensions.vitals
    # gnomeExtensions.system-monitor
    gnomeExtensions.dash-to-dock
    gnomeExtensions.system-monitor-next

    # browsers
    brave
    firefox
    # librewolf

    # communication
    thunderbird
    slack
    signal-desktop

    # docs
    xournalpp
    libreoffice

    # clojure
    clojure babashka clj-kondo clojure-lsp leiningen
    zprint
    # jdk
    openjdk17
    nodejs
    visualvm

    # sql
    dbeaver-bin
    postgresql sqlite
    sqlfluff                  # sql linter

    # latex
    texlive.combined.scheme-full

    # docker
    dockerfile-language-server-nodejs # lsp
    dive                              # analyze docker images

    # http
    postman
    hoppscotch                  # Open-Source Postman

    pandoc
    mermaid-cli
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
