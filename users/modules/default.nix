{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./apps.nix
    ./macos.nix
  ];
}