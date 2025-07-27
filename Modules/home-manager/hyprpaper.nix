{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     preload = [
       "~/.config/Nixos/Modules/home-manager/Wallpapers/sunset-forest-ultrawide.jpg"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Starry-heaven-painting-1080.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/japan-night-pixelart-vertical.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png"
     ];
     wallpaper = [
       "DP-5, ~/.config/Nixos/Modules/home-manager/Wallpapers/sunset-forest-ultrawide.jpg" #monitor 1
       "HDMI-A-2, ~/.config/Nixos/Modules/home-manager/Wallpapers/Starry-heaven-painting-1080.png" #monitor 2
       "DP-6, ~/.config/Nixos/Modules/home-manager/Wallpapers/japan-night-pixelart-vertical.png" #monitor 3
       "DP-4, ~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png" #monitor 4
     ];
   };
 };
}
