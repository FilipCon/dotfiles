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
      # username = "filipkon";
      host = "ideapad";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
      {
        nixosConfigurations = {
          ideapad = lib.nixosSystem {
            inherit system;
            modules = [ nur.nixosModules.nur
                        ./configuration.nix ];
          };
        };

        homeConfigurations = {
          filipkon = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            # modules = [".home.nix"]
          };
        };

      };



}
