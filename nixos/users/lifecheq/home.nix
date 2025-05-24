{ pkgs, ... }:

{
  imports = [ ../common.nix ];

  home.username = "lifecheq";
  home.homeDirectory = "/home/lifecheq";

  programs.git = {
    enable = true;
    userName = "Konstantinos Filip";
    userEmail = "konstantinos.filip@lifecheq.co.za";
    extraConfig = {
      init = {
        defaultBranch = "main";
        # gpg.format = "ssh";
        # user.signingkey = "~/.ssh/id_rsa.pub";

      };
      # Prefer SSH over HTTPS links for cloning repos. ~/.netrc causes issues
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };

  home.packages =  with pkgs; [
    chromium
    heroku

    python3
    # python312Packages.grip

    jmeter
    envsubst
    teams-for-linux
  ];
}
