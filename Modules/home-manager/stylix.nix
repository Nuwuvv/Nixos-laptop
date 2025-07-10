{ config, pkgs, ... }:
{
 stylix = {
   enable = true;
   image = ./Wallpapers/japan-night-painting-4k.png;
   polarity = "dark";
   opacity = {
     terminal = 0.8;
   };
   targets = {
     neovim.enable = false;
     waybar.enable = false;
     dunst.enable = false;
     rofi.enable = false;
   };
   fonts = {
     monospace = {
       package = pkgs.jetbrains-mono;
       name = "JetBrainsMono Nerd Font Mono";
     };
     sansSerif = {
       package = pkgs.dejavu_fonts;
       name = "DejaVu Sans";
     };
     serif = {
       package = pkgs.dejavu_fonts;
       name = "DejaVu Serif";
     };
   };
 };
}
