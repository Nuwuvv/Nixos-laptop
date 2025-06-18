{ config, pkgs, ... }:

 let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      nm-applet --indicator &
      waybar &
      wal -R &
      dunst
    '';
  in
 
{
  home.username = "Nuuvv";
  home.homeDirectory = "/home/Nuuvv";
  imports = [
   ./hyprland.nix
   ./hyprpaper.nix
   ./kitty.nix
   ./stylix.nix
   ];
  
 # stylix = {
 #   enable = true;
 #   image = ./Wallpapers/Forest-night-painting-4k.png; #Gen colorscheme from this image
 #   polarity = "dark";
 #   opacity = {
 #     terminal = 0.8;
 #   };
 #   fonts = {
 #     monospace = {
 #       package = pkgs.jetbrains-mono;
 #       name = "JetBrainsMono Nerd Font Mono";
 #     };
 #     sansSerif = {
 #       package = pkgs.dejavu_fonts;
 #       name = "DejaVu Sans";
 #     };
 #     serif = {
 #       package = pkgs.dejavu_fonts;
 #       name = "DejaVu Serif";
 #     };
 #   };
 # };
  
  # Don't touch
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

# wayland.windowManager.hyprland = {
#    enable = true;
#    settings = {
#      exec-once = ''${startupScript}/bin/start''; 
#    };
#  };
  programs.home-manager.enable = true;
}
