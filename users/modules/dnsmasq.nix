{ pkgs, lib, options, ... }:

{
  services.dnsmasq = {
    enable = true;
    addresses = { localhost = "127.0.0.1"; };
  };
}
