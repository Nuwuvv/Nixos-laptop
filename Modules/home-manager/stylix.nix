{ config, pkgs, lib, ... }:
{
 gtk.gtk4.theme = null;
 stylix = {
   enable = true;
   image = ./Wallpapers/girl-tvs-laptop.png;
   polarity = "dark";
   opacity = {
     terminal = 0.8;
   };
   targets = {
     neovim.enable = false;
     waybar.enable = false;
     dunst.enable = false;
     rofi.enable = false;
     hyprlock.enable = false;
   };
   fonts = {
     monospace = {
       package = pkgs.nerd-fonts.jetbrains-mono;
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
