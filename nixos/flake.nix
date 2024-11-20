{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
      {
        nixosConfigurations = {
          ideapad = lib.nixosSystem {
            inherit system;
            modules =  with self.nixosModules; [
              ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
              nur.nixosModules.nur
              home-manager.nixosModules.home-manager
              platforms.ideapad
              traits.base
              traits.gnome
              services.cups
              users.filipkon
              users.lifecheq
            ];
          };
        };

        homeConfigurations = {
          filipkon = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./users/filipkon/home.nix ];
          };

          lifecheq = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./users/lifecheq/home.nix ];
          };
        };

        nixosModules = {
          platforms.ideapad = ./platforms/ideapad.nix;
          traits.base = ./traits/base.nix;
          traits.gnome = ./traits/gnome.nix;
          services.cups = ./services/cups.nix;
          users.filipkon = ./users/filipkon;
          users.lifecheq = ./users/lifecheq;
        };
      };
}
