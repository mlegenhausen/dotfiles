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

          gc.automatic = true;

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

        system.stateVersion = 5;

        # Fix for the following error:
        # The default Nix build user group ID was changed from 30000 to 350.
        # You are currently managing Nix build users with nix-darwin, but your
        # nixbld group has GID 30000, whereas we expected 350.
        ids.gids.nixbld = 30000;
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
