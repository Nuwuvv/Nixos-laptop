{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     preload = [
       "~/.config/Nixos/Modules/home-manager/Wallpapers/fantasy-house-painting-ultrawide.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/japan-train-cartoon-1080p.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Abstract-painting-girl-birds-japan-4k.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png"
     ];
     wallpaper = [
       "DP-5, ~/.config/Nixos/Modules/home-manager/Wallpapers/fantasy-house-painting-ultrawide.png" #monitor 1
       "HDMI-A-2, ~/.config/Nixos/Modules/home-manager/Wallpapers/japan-train-cartoon-1080p.png" #monitor 2
       "DP-6, ~/.config/Nixos/Modules/home-manager/Wallpapers/Abstract-painting-girl-birds-japan-4k.png" #monitor 3
       "DP-4, ~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png" #monitor 4
     ];
   };
 };
}
