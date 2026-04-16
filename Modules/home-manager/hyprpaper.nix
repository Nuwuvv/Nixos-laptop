{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     splash = false;
     wallpaper = [
       #{
       #  monitor = "DP-5"; #monitor 1
       #  path = "~/.config/Nixos/Modules/home-manager/Wallpapers/flute-girl-ducks-ultrawide.png";
       #} Now stylix lets me target a monitor so this is not needed :)
       { 
        monitor = "HDMI-A-2"; #monitor 2
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/japan-train-cartoon-1080p.png";
       }
       {
         monitor = "DP-6"; #monitor 3
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/girl-birds-dark-painting-vertical.png";
       }
       {
         monitor = "DP-4"; #monitor 4
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png";
       } 
     ];
  };
 };
}
