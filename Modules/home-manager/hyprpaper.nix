{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     preload = [
       "~/.config/Nixos/Modules/home-manager/Wallpapers/austronaut-starts-4k.jpg"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Starry-heaven-painting-1080.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/crossing-japan-vertical.jpeg"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png"
     ];
     wallpaper = [
       "DP-5, ~/.config/Nixos/Modules/home-manager/Wallpapers/austronaut-starts-4k.jpg" #monitor 1
       "HDMI-A-2, ~/.config/Nixos/Modules/home-manager/Wallpapers/Starry-heaven-painting-1080.png" #monitor 2
       "DP-6, ~/.config/Nixos/Modules/home-manager/Wallpapers/crossing-japan-vertical.jpeg" #monitor 3
       "DP-4, ~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png" #monitor 4
     ];
   };
 };
}
