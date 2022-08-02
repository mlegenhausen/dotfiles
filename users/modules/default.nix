{ pkgs, lib, options, ... }:

{
  imports = [ ./apps.nix ./dnsmasq.nix ./fonts.nix ./macos.nix ./nix.nix ./zsh.nix ];
}
