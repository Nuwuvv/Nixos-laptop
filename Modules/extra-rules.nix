{ pkgs, config, ... }:
{
  security.sudo.extraRules = [
    {
      users = [ "Nuuvv" ];
      commands = [
        { command = "/run/current-system/sw/bin/systemctl start wg-quick-wg0"; options = [ "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/systemctl stop wg-quick-wg0"; options = [ "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/tlp"; options = [ "NOPASSWD" ]; }
      ];  
    }
  ];
}
