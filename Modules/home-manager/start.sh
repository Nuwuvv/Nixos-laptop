#! /usr/bin/env bash

# initializing network manager applet

nm-applet --indicator &

# initializing Status Bar

waybar -c ~/.config/waybar/config.ini &

# initializing Wallpaper

hyprpaper &

# initializing notification daemon

dunst
 
