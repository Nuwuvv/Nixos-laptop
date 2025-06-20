{ config, pkgs, ... }:
{
 stylix = {
   enable = true;
   image = ./Wallpapers/Forest-night-4k.png;
   polarity = "dark";
   opacity = {
     terminal = 0.8;
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
