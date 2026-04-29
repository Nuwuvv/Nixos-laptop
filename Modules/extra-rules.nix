{ pkgs, config, ... }:
{
  services.udev.extraRules = ''
    ACTION=="charge", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="${pkgs.tlp}/bin/tlp setcharge 60 BAT0"
  '';
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
