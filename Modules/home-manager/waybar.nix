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
       height = 25;
       modules-left = [ "custom/launcher" "hyprland/workspaces" "cava" "mpris" "bluetooth" "tray" ];
       modules-center = [ "hyprland/window" ];
       modules-right = [ "network" "disk" "memory" "cpu" "pulseaudio" "custom/weather" "clock" ];
 
       "custom/launcher" = {
         format = "󱄅";
         on-click = "grim -o DP-5";
         on-click-right = "grim -g \"$(slurp)\"";
       };
 
       "hyprland/workspaces" = {
         active-only = false;
         all-outputs = true;
         disable-scroll = false;
         on-scroll-up = "hyprctl dispatch workspace e-1";
         on-scroll-down = "hyprctl dispatch workspace e+1";
         format = "{icon}";
         on-click = "activate";
         format-icons = {
           urgent = "";
           active = "";
           default = "";
         };
         sort-by-number = true;
       };

       "cava" = {
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
         format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
         actions = {
           on-click-right = "mode";
         };
       };

       "mpris" = {
         format = "{player_icon}  {status_icon}  {title} - {artist}";
         format-paused = "{player_icon}  {status_icon}  {title} - {artist}";
         max-length = 35;
         on-scroll-up = "playerctld shift";
         on-scroll-down = "playerctld shift";
         player-icons = {
           default = "󰎈";
           mpv = "";
           vlc = "<span color='#E85E00'>󰕼</span>";
           spotify = "<span size='16000' color='#1DB954'></span>";
           brave = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>";
         };
         status-icons = {
           paused = "";
           playing = "⏸";
           stopped = "";
         };
       };

       "bluetooth" = {
         format-on = "<span size='14000'>󰂯</span>";
         format-off = "<span size='14000' foreground='#f37061'>󰂲</span>";
         on-click = "bluetoothctl power on";
         on-click-right = "bluetoothctl power off";
       };

       "tray" = {
         icon-size = 21;
         spacing = 10;
       };

       "hyprland/window" = {
         format = "{}";
         max-length = 45;
         rewrite = {
           "(.*) - Brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span> $1";
           "(.*) - kitty" = "<span font='normal Font Awesome 6 Free' ></span> $1";
           "(.*) - Discord" = "<span color='#5378f3'></span> $1";
         };
         separate-outputs = true;
       };

       "network" =  {
         format = "{bandwidthDownBits} <span size='18000' foreground='#61f38d'>󰁈</span>  | {bandwidthUpBits} <span size='18000' foreground='#f37e8a'>󰁠</span>";
         interval = 1;
       };

       "disk" = {
         format = "<span size='18000' ></span> {}%";
         format-alt = "<span size='18000'></span> {used}/{total} GiB";
         interval = 20;
         path = "/";
       };

       "memory" = {
         format = "  {}%";
         format-alt = "  {used}/{total} GiB";
         interval = 5;
       };

       "cpu" = {
         format = "<span size='17000'>󰍛</span> {usage}%";
         format-alt = "<span size='17000'>󰍛</span> {avg_frequency} GHz";
         interval = 5;
       };

       "pulseaudio" = {
         format = "<span size='15000'>{icon}</span> {volume}%";
         format-muted = " <span size='18000' foreground='#f37061'>󰝟</span> {volume}% ";
         format-icons = {
           headphone = "";
           hands-free = "";
           headset = "";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = "~/.config/Nixos/Modules/home-manager/scripts/toggle-sinks.sh";
         on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
         on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
       };

        "custom/weather" = {
         format = "{}°";
         tooltip = true;
         interval = 600;
         exec = "wttrbar --nerd";
         return-type = "json";
       }; 

       "clock" = {
         interval = 1;
         format = " {:%a  %B %d    %H:%M}";
         format-alt = "  {:%H:%M}";
         tooltip-format = "<tt>{calendar}</tt>";
         calendar = {
           mode-mon-col = 3;
           format = {
             months = "<span color='#f3f3f3'><b>{}</b></span>";
             weekdays = "<span color='#9e79f3'><b>{}</b></span>";
             today = "<span color='#f36849'><b><u>{}</u></b></span>";
             days = "<span size='10pt' color='#f3f3f3'><b>{}</b></span>";
           };
         };
       };
     };

    verticalMonitorBar = {
       output = [
         "DP-6"
       ];
       position = "top";
       layer = "top";
       height = 14;
       modules-left = [ "custom/launcher" "hyprland/workspaces" "tray" ];
       modules-center = [ "hyprland/window" ];
       modules-right = [ "pulseaudio" "clock" ];
 
       "custom/launcher" = {
         format = "󱄅";
         on-click = "grim -o DP-5";
         on-click-right = "grim -g \"$(slurp)\"";
       };

       "hyprland/workspaces" = {
         active-only = false;
         all-outputs = true;
         disable-scroll = false;
         on-scroll-up = "hyprctl dispatch workspace e-1";
         on-scroll-down = "hyprctl dispatch workspace e+1";
         format = "{icon}";
         on-click = "activate";
         format-icons = {
           urgent = "";
           active = "";
           default = "";
         };
         sort-by-number = true;
       };

       "tray" = {
         icon-size = 21;
         spacing = 10;
       };

       "hyprland/window" = {
         format = "{}";
         max-length = 35;
         rewrite = {
           "(.*) - Brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span> $1";
           "(.*) - kitty" = " $1";
           "(.*) - Discord" = "<span color='#5378f3'></span> $1";
         };
         separate-outputs = true;
       };

       "pulseaudio" = {
         format = "<span size='15000'>{icon}</span> {volume}%";
         format-muted = " <span size='18000' foreground='#f37061'>󰝟</span> {volume}% ";
         format-icons = {
           headphone = "";
           hands-free = "";
           headset = "";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = "~/.config/Nixos/Modules/home-manager/scripts/toggle-sinks.sh";
         on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
         on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
       };

       "clock" = {
         interval = 1;
         format = " {:%a  %B %d    %H:%M}";
         format-alt = "  {:%H:%M}";
         tooltip-format = "<tt>{calendar}</tt>";
         calendar = {
           mode-mon-col = 3;
           format = {
             months = "<span color='#f3f3f3'><b>{}</b></span>";
             weekdays = "<span color='#9e79f3'><b>{}</b></span>";
             today = "<span color='#f36849'><b><u>{}</u></b></span>";
             days = "<span size='10pt' color='#f3f3f3'><b>{}</b></span>";
           };
         };
       };
     };
     "1080pBar" = {
       output = [
         "HDMI-A-2"
       ];
       position = "top";
       layer = "top";
       height = 14;
       modules-left = [ "custom/launcher" "hyprland/workspaces" "mpris" "tray" ];
       modules-center = [ "hyprland/window" ];
       modules-right = [ "pulseaudio" "custom/weather" "clock" ];
 
       "custom/launcher" = {
         format = "󱄅";
         on-click = "grim -o DP-5";
         on-click-right = "grim -g \"$(slurp)\"";
       };
 
       "hyprland/workspaces" = {
         active-only = false;
         all-outputs = true;
         disable-scroll = false;
         on-scroll-up = "hyprctl dispatch workspace e-1";
         on-scroll-down = "hyprctl dispatch workspace e+1";
         format = "{icon}";
         on-click = "activate";
         format-icons = {
           urgent = "";
           active = "";
           default = "";
         };
         sort-by-number = true;
       };

       "mpris" = {
         format = "{player_icon}  {status_icon}  {title} - {artist}";
         format-paused = "{player_icon}  {status_icon}  {title} - {artist}";
         max-length = 30;
         on-scroll-up = "playerctld shift";
         on-scroll-down = "playerctld shift";
         player-icons = {
           default = "󰎈";
           mpv = "";
           vlc = "<span color='#E85E00'>󰕼</span>";
           spotify = "<span color='#1DB954'></span>";
           brave = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>";
         };
         status-icons = {
           paused = "";
           playing = "⏸";
           stopped = "";
         };
       };

       "tray" = {
         icon-size = 21;
         spacing = 10;
       };

       "hyprland/window" = {
         format = "{}";
         max-length = 40;
         rewrite = {
           "(.*) - Brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span> $1";
           "(.*) - kitty" = " $1";
           "(.*) - Discord" = "<span color='#5378f3'></span> $1";
         };
         separate-outputs = true;
       };

       "pulseaudio" = {
         format = "<span size='15000'>{icon}</span> {volume}%";
         format-muted = " <span size='18000' foreground='#f37061'>󰝟</span> {volume}% ";
         format-icons = {
           headphone = "";
           hands-free = "";
           headset = "";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = "~/.config/Nixos/Modules/home-manager/scripts/toggle-sinks.sh";
         on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
         on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
       };

       "clock" = {
         interval = 1;
         format = " {:%a  %B %d    %H:%M}";
         format-alt = "  {:%H:%M}";
         tooltip-format = "<tt>{calendar}</tt>";
         calendar = {
           mode-mon-col = 3;
           format = {
             months = "<span color='#f3f3f3'><b>{}</b></span>";
             weekdays = "<span color='#9e79f3'><b>{}</b></span>";
             today = "<span color='#f36849'><b><u>{}</u></b></span>";
             days = "<span size='10pt' color='#f3f3f3'><b>{}</b></span>";
           };
         };
       };

       "custom/weather" = {
         format = "{}°";
         tooltip = true;
         interval = 600;
         exec = "wttrbar --nerd";
         return-type = "json";
       }; 
     };
   };
 };
}
