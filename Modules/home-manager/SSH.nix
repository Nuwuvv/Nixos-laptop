{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    listenAdresses = [
      { addr = "10.0.0.102"; port = 22; }
      { addr = "10.10.0.0"; port = 22; }
    ]; 
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.Nuuvv.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPODeeWaLi94hFyrF2kzz4mC8moMhlPrFgd/GPj4E3ys nuuvv-nix"
  ];
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
