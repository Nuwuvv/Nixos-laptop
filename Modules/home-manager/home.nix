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

  programs.home-manager.enable = true;
}
