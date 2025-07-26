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
   ./fastfetch.nix
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

 #virt-manager error fix
 dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

 programs.home-manager.enable = true;
}
