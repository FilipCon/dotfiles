{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/master";
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
              nur.modules.nixos.default
              home-manager.nixosModules.home-manager
              platforms.ideapad
              traits.base
              traits.gnome
              # traits.nvidia
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
          traits.nvidia = ./traits/nvidia.nix;
          services.cups = ./services/cups.nix;
          users.filipkon = ./users/filipkon;
          users.lifecheq = ./users/lifecheq;
        };
      };
}
