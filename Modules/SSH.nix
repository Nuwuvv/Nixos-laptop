{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "homelab" = {
        hostname = "10.0.0.50";
        user = "Nuurvver";
        forwardAgent = true;
      };
      "vps" = {
        hostname = "45.77.198.8";
        user = "Nuwuvv";
      };
      "router" = {
        hostname = "10.0.0.1";
        user = "nuwuvv";
      };
    };
  };
}
