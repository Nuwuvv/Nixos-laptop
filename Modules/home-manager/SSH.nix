{ config, lib, pkgs, ... }:

{
  home.file.".ssh/config".text = ''
  Host homelab
    HostName 10.0.0.50
    User Nuurvver
    ForwardAgent yes

  Host vps
    HostName 45.77.198.8
    User Nuwuvv

  Host router
    HostName 10.0.0.1
    User nuwuvv

  Host nix
    HostName 10.0.0.102
    User Nuuvv

  Host sigilos
    HostName 10.0.0.119
    User Nuuvv

  Host White
    HostName 10.0.0.120
    User Nuuvv

  Host aws
    HostName 52.15.238.228
    User Nuuvv

'';
 # programs.ssh = {
 #   matchBlocks = {
 #     "homelab" = {
 #       hostname = "10.0.0.50";
 #       user = "Nuurvver";
 #       forwardAgent = true;
 #     };
 #     "vps" = {
 #       hostname = "45.77.198.8";
 #       user = "Nuwuvv";
 #     };
 #     "router" = {
 #       hostname = "10.0.0.1";
 #       user = "nuwuvv";
 #     };
 #   };
 # };
}
