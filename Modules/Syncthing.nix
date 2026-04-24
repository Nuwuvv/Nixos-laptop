{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    user = "Nuuvv";
    dataDir = "/home/Nuuvv/Sync";
    configDir = "/home/Nuuvv/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "homelab" = {
          id = "L4NWISE-HG4E7C7-3I3443Z-FUGZWDC-IP66RPU-6FMU3CV-VMYK4UH-SATEWA6";
        };
      };
      folders = {
        "tkkyg-khdnr" = {
          label = "Share";
          path = "/home/Nuuvv/Share";
          devices = [ "homelab" ];
        };
      };
    };
  };
}
