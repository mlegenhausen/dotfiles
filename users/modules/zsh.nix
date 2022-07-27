{ pkgs, lib, options, ... }:

{
  # Add zsh to /etc/shells
  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;
}
