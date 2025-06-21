{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     preload = [
       "~/Wallpapers/Forrest-night-painting-4k.png"
       "~/Wallpapers/Anime-purple-sky-painting-1080p.png"
       "~/Wallpapers/Abstract-painting-girl-birds-japan-4k.png"
       "~/Wallpapers/Positive-duck-happy4k.png"
     ];
     wallpaper = [
       "DP-5, ~/Wallpapers/Forrest-night-painting-4k.png" #monitor 1
       "HDMI-A-2, ~/Wallpapers/Anime-purple-sky-painting-1080p.png" #monitor 2
       "DP-6, ~/Wallpapers/Abstract-painting-girl-birds-japan-4k.png" #monitor 3
       "DP-4, ~/Wallpapers/Positive-duck-happy4k.png" #monitor 4
     ];
   };
 };
}
