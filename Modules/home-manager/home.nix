{ inputs, config, pkgs, ... }:

{
 home.username = "Nuuvv";
 home.homeDirectory = "/home/Nuuvv";
 imports = [
   ./hyprland.nix
   ./hyprpaper.nix
   ./kitty.nix
   ./stylix.nix
   inputs.stylix.homeModules.stylix
   ./waybar.nix
   ./waybar-style.nix
   ./nvim.nix
   ./rofi.nix
   ./dunst.nix
 ];

 # Don't touch
 home.stateVersion = "25.05";

 home.packages = with pkgs; [
 ];

 home.file = {

 };

 home.sessionVariables = {
   EDITOR = "nvim";
 };

 programs.home-manager.enable = true;
}
