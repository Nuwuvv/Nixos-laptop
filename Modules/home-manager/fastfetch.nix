{ inputs, config, pkgs, ... }:
{
  programs = {
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "/home/Nuuvv/Downloads/rem-gif.webm";
        };
      };
    };
  };
}  
