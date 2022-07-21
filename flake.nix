{
  description = "MacOS configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

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
          package = pkgs.nixFlakes;

          extraOptions = ''
            experimental-features = nix-command flakes
          '';

          binaryCaches = [
            "https://cache.nixos.org"
          ];

          binaryCachePublicKeys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          ];

          gc = {
            automatic = true;
            options = "--delete-older-than 2w";
          };
        };

        nixpkgs = {
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        };
      };
    in
    {
      darwinConfigurations = {
        Maltes-MacBook-Pro = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit inputs;

          modules = [
            inputs.homemanager.darwinModules.home-manager
            sharedDarwinConfiguration
            ./machines/macbook-pro
            ./darwin-configuration.nix
          ];
        };

        Maltes-MacBook-Air = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit inputs;

          modules = [
            inputs.homemanager.darwinModules.home-manager
            sharedDarwinConfiguration
            ./machines/macbook-air
            ./darwin-configuration.nix
          ];
        };
      };
    };
}