{ config, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    listenAddresses = [
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
}
