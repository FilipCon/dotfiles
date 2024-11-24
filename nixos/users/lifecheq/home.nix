{ pkgs, ... }:

{
  imports = [ ../common.nix ];

  home.username = "lifecheq";
  home.homeDirectory = "/home/lifecheq";

  home.packages =  with pkgs; [
    # browsers
    chromium
  ];
}
