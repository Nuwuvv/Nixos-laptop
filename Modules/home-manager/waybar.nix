{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        output = [
          "DP-5"
          "DP-4"
        ];
        position = "top";
        layer = "top";
        height = 14;
        modules-left = [ "custom/launcher" "hyprland/workspaces" "cava" "mpris" "bluetooth" "tray" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "network" "disk" "memory" "cpu" "pulseaudio" "custom/weather" "clock" ];
 
        "custom/launcher" = {
          format = "󱄅";
          on-click = "grim -o DP-5";
          on-click-right = "grim -g \"$(slurp)\"";
        };
 
        "cava" = {
          cava_config =  "$XDG_CONFIG_HOME/cava/config";
          framerate = 30;
          autosens = 1;
          sensitivity = 1;
          bars = 14;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.77;
          input_delay = 2;
          format-icons = ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" ];
          actions = {
            on-click-right = "mode";
          };
       };
     };
   };
 };
}
