{ pkgs, config, ... }:
{
 environment.systemPackages = with pkgs; [
   waybar
   neofetch
   kitty
   libnotify
   hyprpaper
   brave
   librewolf
   wget
   btop
   nnn
   legcord
   linuxKernel.packages.linux_zen.xone
   nvtopPackages.nvidia
   obs-studio
   keepassxc
   grim
   slurp
   gimp3
   usbutils
   home-manager
   yazi
   cava
   spotify
   vlc
   git
   davinci-resolve
   audacity
   krita
   stremio
   wttrbar
   nvd #dependency for update waybar module
   spotify-player
 ];
}
