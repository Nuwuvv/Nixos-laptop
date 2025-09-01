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
   discord
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
   tenacity
   krita
   stremio
   wttrbar
   nvd #dependency for update waybar module
   spotify-player
   dysk
   unzip
   nh
   libreoffice-qt6-fresh
   ffmpeg #dependency for fastfetch
 ];
 #Temp fix until stremio is updated, try to remove this in a week and check if nh os switch builds
 nixpkgs.config.permittedInsecurePackages = [
   "qtwebengine-5.15.19"
 ];
}
