{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };

      lib = nixpkgs.lib;
    in
      {
        nixosConfigurations = {
          ideapad = lib.nixosSystem {
            inherit system;
            modules = [ ./configuration.nix ];
          };
        };
      };
}
