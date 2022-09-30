{
  description = "MacOS configurations";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homemanager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      sharedDarwinConfiguration = { config, pkgs, ... }: {
        nix = {
          package = pkgs.nixVersions.stable;

          extraOptions = ''
            experimental-features = nix-command flakes
          '';

          gc = {
            automatic = true;
            options = "--delete-older-than 2w";
          };

          settings = {
            substituters = [ "https://cache.nixos.org" ];
            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            ];
          };
        };

        nixpkgs = {
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        };
      };
    in {
      darwinConfigurations = {
        Maltes-MacBook-Pro = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit inputs;

          modules = [
            inputs.homemanager.darwinModules.home-manager
            sharedDarwinConfiguration
            ./machines/macbook-pro
            ./users/mlegenhausen
          ];
        };

        Maltes-MacBook-Air = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit inputs;

          modules = [
            inputs.homemanager.darwinModules.home-manager
            sharedDarwinConfiguration
            ./machines/macbook-air
            ./users/mlegenhausen
          ];
        };
      };
    };
}
