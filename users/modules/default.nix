{ pkgs, lib, options, ... }:

{
  imports = [ ./apps.nix ./fonts.nix ./macos.nix ./nix.nix ./zsh.nix ];
}
