{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     preload = [
       "~/.config/Nixos/Modules/home-manager/Wallpapers/pastel-pink-planet-ultrawide.jpg"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/japan-train-cartoon-1080p.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/japan-night-pixelart-vertical.png"
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png"
     ];
     wallpaper = [
       "DP-5, ~/.config/Nixos/Modules/home-manager/Wallpapers/pastel-pink-planet-ultrawide.jpg" #monitor 1
       "HDMI-A-2, ~/.config/Nixos/Modules/home-manager/Wallpapers/japan-train-cartoon-1080p.png" #monitor 2
       "DP-6, ~/.config/Nixos/Modules/home-manager/Wallpapers/japan-night-pixelart-vertical.png" #monitor 3
       "DP-4, ~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png" #monitor 4
     ];
   };
 };
}
