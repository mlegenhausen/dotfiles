{ pkgs, lib, options, ... }:

{
  imports = [
    ./apps.nix
    ./dnsmasq.nix
    ./fonts.nix
    ./lorri.nix
    ./macos.nix
    ./nix.nix
    ./zsh.nix
  ];
}
