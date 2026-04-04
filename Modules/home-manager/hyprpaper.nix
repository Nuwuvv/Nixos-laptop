{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     splash = false;
     wallpaper = [
       {
         monitor = "DP-5"; #monitor 1
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/girl-window-sitting-ultrawide.jpg";
       }
       { 
        monitor = "HDMI-A-2"; #monitor 2
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/Starry-heaven-painting-1080.png";
       }
       {
         monitor = "DP-6"; #monitor 3
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/crossing-japan-vertical.jpeg";
       }
       {
         monitor = "DP-4"; #monitor 4
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png";
       } 
     ];
  };
 };
}
