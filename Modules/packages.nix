{ pkgs, config, ... }:
{
 environment.systemPackages = with pkgs; [
   waybar
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
   #stremio-linux-shell
   wttrbar
   nvd #dependency for update waybar module
   spotify-player
   dysk
   unzip
   nh
   libreoffice-qt6-fresh
   ffmpeg #dependency for fastfetch
   heroic
   gcc
   yt-dlp-light
   psmisc #killall
   ocl-icd #opencl for nvidia gpus
 ];
}
