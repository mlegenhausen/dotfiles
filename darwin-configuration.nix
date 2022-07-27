{ config, lib, pkgs, ... }:

{
  environment.shells = [ pkgs.zsh ];

  environment.variables = { LANG = "en_US.UTF-8"; };

  fonts.fontDir.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;
}
