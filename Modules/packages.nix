{ pkgs, config, ... }:
{
 environment.systemPackages = with pkgs; [
   waybar
   kitty
   libnotify
   hyprpaper
   brave
   #librewolf
   wget
   btop
   nnn
   discord
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
   stremio-linux-shell
   wttrbar
   nvd #dependency for update waybar module
   dysk
   unzip
   nh
   libreoffice-qt
   ffmpeg #dependency for fastfetch
   gcc
   yt-dlp-light
   psmisc #killall
   ocl-icd #opencl for nvidia gpus
   brightnessctl
   bluetuith
   radeontop
   kopia
   feishin
   pkgs.xivlauncher
   pkgs.piper
 ];
}
