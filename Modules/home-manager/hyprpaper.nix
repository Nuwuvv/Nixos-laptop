{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     splash = false;
     wallpaper = [
     ];
  };
 };
}
