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
   #./hyprland.nix
   #./hyprpaper.nix
   #./kitty.nix
   #./stylix
   ];
  
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
