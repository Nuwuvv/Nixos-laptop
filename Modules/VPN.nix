{ config, lib, pkgs, ... }:
{
  networking.wg-quick.interfaces.wg0 = {
    autostart = false;
    address = [ "10.10.0.5/24" ];
    privateKeyFile = "/etc/wireguard/private.key";
    dns = [ "10.0.0.1" ];
    peers = [
      {
        publicKey = "7gEkjxLsR8mI0M9zo5GJX/tkQb1WQrsOK/0XVPBJDg4=";
        allowedIPs = [ "10.10.0.0/24" "10.0.0.0/24" ];
        endpoint = "vpn.sigilos.st:51820";
        persistentKeepalive = 25;
      }
    ];
  };
  networking.wg-quick.interfaces.wg1 = {
    autostart = false;
    address = [ "10.10.0.5/24" ];
    privateKeyFile = "/etc/wireguard/private.key";
    dns = [ "10.10.0.1" ];
    peers = [
      {
        publicKey = "faXOJ2U5Un1t/Qpx2E7NDeIQWMTKNZyYXn1g1q0kfXI=";
        allowedIPs = [ "10.10.0.0/24" "10.0.0.0/24" ];
        endpoint = "45.77.198.8:51820";
        persistentKeepalive = 25;
      }
    ];
  };
}

