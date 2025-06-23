{
  services = {
    syncthing = {
      enable = true;
      user = "Nuuvv";
      dataDir = "/home/Nuuvv/Sync"; # Default folder for new synced folders
      configDir = "/home/Nuuvv/.config/syncthing"; # Folder for Syncthing's settings and keys
      settings = {
        gui = {
          user = "Nuuvv";
          password = "2696";
      };
        devices = {
          "pixel 8" = { id = "WGMDKLY-VV4GWTV-NGYUBUS-2WEAUNB-ZQ4SJR7-NQYQIA7-XNKMEAB-44WNWAM"; };
        };
        folders = {
          "Keys" = {
             path = "/home/Nuuvv/.config/keepassxc";
             devices = [ "pixel 8" ];
          };
        };
      };
    };
  };
}
