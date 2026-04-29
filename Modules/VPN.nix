{ config, lib, pkgs, ... }:
{
  networking.wg-quick.intefaces.wg0 = {
    address = [ "10.10.0.5/24" ];
    privateKeyFile = "/etc/wireguard/private.key";
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

