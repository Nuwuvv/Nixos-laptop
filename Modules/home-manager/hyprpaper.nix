{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     splash = false;
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Cat-sea-bus-station-4k.png"
    #   "~/.config/Nixos/Modules/home-manager/Wallpapers/night-moon-green-ultrawide.jpg"
    #   "~/.config/Nixos/Modules/home-manager/Wallpapers/Starry-heaven-painting-1080.png"
    #   "~/.config/Nixos/Modules/home-manager/Wallpapers/crossing-japan-vertical.jpeg"
    #   "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png"
    # ];
       "DP-5, ~/.config/Nixos/Modules/home-manager/Wallpapers/Cat-sea-bus-station-4k.png" #monitor 1
    # wallpaper = [
    #   "DP-5, ~/.config/Nixos/Modules/home-manager/Wallpapers/night-moon-green-ultrawide.jpg"
    #   "HDMI-A-2, ~/.config/Nixos/Modules/home-manager/Wallpapers/Starry-heaven-painting-1080.png"
    #   "DP-6, ~/.config/Nixos/Modules/home-manager/Wallpapers/crossing-japan-vertical.jpeg"
    #   "DP-4, ~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png"
    # ];



     wallpaper = [
       {
         monitor = "DP-5"; #monitor 1
         path = "~/.config/Nixos/Modules/home-manager/Wallpapers/night-moon-green-ultrawide.jpg";
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
