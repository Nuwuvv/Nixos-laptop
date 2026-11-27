{ config, pkgs, lib, ... }:
let
  myCursor = pkgs.runCommand "my-cursor" {} ''
    mkdir -p $out/share/icons/Mini-Sleek
    cp -r ${./Mini-Sleek}/* $out/share/icons/Mini-Sleek/
  '';
in
{
  stylix.cursor = {
    package = myCursor;
    name = "Mini-Sleek";
    size = 128;
  };
 stylix = {
   enable = true;
   overlays.enable = false;
   image = ./Wallpapers/rocky-sea-laptop.png;
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
