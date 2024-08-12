{ pkgs, lib, options, ... }:

{
  imports = [
    ./apps.nix
    ./dnsmasq.nix
    ./lorri.nix
    ./macos.nix
    ./nix.nix
    ./zsh.nix
  ];
}
