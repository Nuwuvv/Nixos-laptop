{ config, pkgs, ... }:
let
  toggleSinks-sh = pkgs.pkgs.writeShellScriptBin "ToggleSinks" ''
    # Add sink names (separated with '|') to SKIP while switching with this script. Choose names to skip from the output of this command:
    # wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a "vol:"
    # if no skip names are added, this script will switch between every available audio sink (output).
    SINKS_TO_SKIP=("alsa_output.pci-0000_01_00.1.hdmi-stereo")

    #Define Aliases (OPTIONAL)
    #ALIASES="sink_name1:Scarlett 4i4 4th Gen Analog Surround 2.1\nsink_name2:G560 Gaming Speaker Analog Surround 2.1"

    #Create array of sink names to switch to
    declare -a SINKS_TO_SWITCH=(''$(wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a "vol:" | tr -d \* | awk '{print (''$3)}' | grep -Ev ''$SINKS_TO_SKIP))
    SINK_ELEMENTS=''$(echo ''${#SINKS_TO_SWITCH[@]})

    #Get current sink name and array position
    ACTIVE_SINK_NAME=''$(wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a '*' | awk '{print (''$4)}')
    ACTIVE_ARRAY_INDEX=''$(echo ''${SINKS_TO_SWITCH[@]/''$ACTIVE_SINK_NAME//} | cut -d/ -f1 | wc -w | tr -d ' ')

    #Get next array name and then its ID to switch to
    NEXT_ARRAY_INDEX=''$(((''$ACTIVE_ARRAY_INDEX+1)%''$SINK_ELEMENTS))
    NEXT_SINK_NAME=''${SINKS_TO_SWITCH[''$NEXT_ARRAY_INDEX]}
    NEXT_SINK_ID=''$(wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a ''$NEXT_SINK_NAME | awk '{print (''$2+0)}')

    #Switch to sink & notify
    wpctl set-default ''$NEXT_SINK_ID
    out=''$(gdbus call --session \
      --dest org.freedesktop.Notifications \
      --object-path /org/freedesktop/Notifications \
      --method org.freedesktop.Notifications.CloseNotification \
      "''$(cat /tmp/sss.id 2>/dev/null)" 2>/dev/null)
    ALIAS=''$(echo -e ''$ALIASES | grep ''$NEXT_SINK_NAME | awk -F ':' '{print (''$2)}')
    out=''$(gdbus call --session \
      --dest org.freedesktop.Notifications \
      --object-path /org/freedesktop/Notifications \
      --method org.freedesktop.Notifications.Notify sss \
      0 \
      gtk-dialog-info "Sound Sink Switcher" "Switching to ''$NEXT_SINK_ID : ''$NEXT_SINK_NAME (''$ALIAS)" [] {} 5000 | \
      sed 's/(uint32 \([0-9]\+\),)/\1/g' > /tmp/sss.id)
  '';

  # WireGuard toggle: the lock ignores a duplicate click while the first is handled;
  # the signal makes the bar icon refresh immediately.
  vpnToggle = pkgs.writeShellScript "vpn-toggle" ''
    exec 9>/tmp/vpn-toggle.lock
    ${pkgs.util-linux}/bin/flock -n 9 || exit 0
    if systemctl is-active --quiet wg-quick-wg0; then
      sudo systemctl stop wg-quick-wg0
    else
      sudo systemctl start wg-quick-wg0
    fi
    ${pkgs.procps}/bin/pkill -RTMIN+8 waybar
    sleep 3
  '';

  # Hyprland >= 0.55 Lua dispatcher; "hyprctl dispatch workspace e-1" is rejected.
  wsPrev = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"e-1\" })'";
  wsNext = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"e+1\" })'";
     
in  
{
 imports = [
   ./updates-waybar.nix
 ];
 programs.waybar = {
   enable = true;
   settings = {
     mainBar = {
       output = [
         "eDP-2"
       ];
       position = "top";
       layer = "top";
       height = 25;
       modules-left = [ "custom/launcher" "group/G1" "group/G2" ];
       modules-center = [ "mpris" ];
       expand-center = true;
       fixed-center = false;
       modules-right = [ "group/G3" "clock" ];
 
       "custom/launcher" = {
         format = "󱄅";
         on-click = "grim -o DP-5";
         on-click-right = "grim -g \"$(slurp)\"";
       };

       "group/G1" = {
         orientation = "horizontal";
         modules = [ "custom/Nix" "hyprland/workspaces" "custom/vpn" ];
       };

       "custom/Nix" = {
         format = "Nix OS";
         on-click = "rofi -show drun -show-icons";
       };
 
       "hyprland/workspaces" = {
         active-only = false;
         all-outputs = true;
         disable-scroll = false;
         on-scroll-up = wsPrev;
         on-scroll-down = wsNext;
         format = "{icon}";
         # on-click = "activate";  # broken on Waybar 0.15 + Lua dispatcher
         min-length = 10;
         max-length = 10;
         format-icons = {
           urgent = "";
           active = "󰮯";
           default = "󰊠";
         };
         sort-by-number = true;
       };

       "custom/vpn" = {
         exec = ''bash -c 'if systemctl is-active --quiet wg-quick-wg0; then echo "{\"text\": \"󰇧\", \"class\": \"connected\"}"; else echo "{\"text\": \"󰇧\", \"class\": \"disconnected\"}"; fi' '';
         return-type = "json";
         interval = 5;
         on-click = "${vpnToggle}";
         signal = 8;
         tooltip = false;
       };

       "group/G2" = {
         orientation = "horizontal";
         modules = [ "backlight" "bluetooth" "custom/updates" "custom/weather" "tray" ];
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

       "backlight" = {
         device = "amdgpu_bl2";
         format = "<span color='#e1ad30' size='16100' >{icon}</span> <span color='#FDFDFD'>{percent}%</span>";
         format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
         on-scroll-up = "brightnessctl -e4 -n2 set 2%+";
         on-scroll-down = "brightnessctl -e4 -n2 set 2%-";
         tooltip = false;
       };

       "mpris" = {
         format = "{player_icon}  {status_icon}  {title} - {artist}";
         format-paused = "{player_icon}  {status_icon}  {title} - {artist}";
         max-length = 30;
         expand = true;
         justify = "center";
         on-scroll-up = "playerctld shift";
         on-scroll-down = "playerctld shift";
         player-icons = {
           default = "󰎈";
           mpv = "";
           vlc = "<span color='#E85E00'>󰕼</span>";
           spotify = "<span size='14950' color='#1DB954'></span>";
           spotify_player = "<span size='14950' color='#1DB954'></span>";
           brave = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>";
         };
         status-icons = {
           paused = "";
           playing = "";
           stopped = "";
         };
       };

       "bluetooth" = {
         format-on = "<span size='16100'>󰂯</span>";
         format-off = "<span size='16100' foreground='#f37061'>󰂲</span>";
         on-click = "kitty --class floating -e bluetuith";
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
           "(.*) - Brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>  $1";
           "(.*) - Discord" = "<span color='#5378f3'></span> $1";
         };
         separate-outputs = true;
       };

  "group/G3" = {
         orientation = "horizontal";
         modules = [ "disk" "cpu" "memory" "network" "pulseaudio" "battery" ];
       };

       "network" =  {
         interface = "wlp4s0";
         format-wifi = "<span color='#4caca9' size='18400'>{icon}</span><span rise='2500'>  {bandwidthDownBits}</span>"; 
         format-disconnected = "<span color='#5f0000' size='18400'>󰤮</span>  Offline";
         format-disabled = "<span color='#0c0d0d size='18400''>󰤬</span>  Disabled";
         format-linked = "<span color='#4caca9' size='18400'></span> {bandwithDownBits}";
         format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
         tooltip-format-wifi = "{essid} {signalStrength}%\n{ipaddr}";
         tooltip-format-disconnected = "Disconnected";
         on-click-right = "nmcli radio wifi off";
         on-click = "kitty --class floating -e nmtui";
         interval = 1;
       };

       "disk" = {
         format = "<span color='#c574dd' size='17250'></span><span rise='2500'> {}%</span>";
         format-alt = "   {used}/{total} GiB";
         interval = 20;
         path = "/";
       };

       "memory" = {
         format = "<span color='#f0b92f' size='17250'></span><span rise='2500'> {}%</span>";
         format-alt = "<span color='#f0b92f' size='17250'></span>  {used}/{total} GiB";
         interval = 5;
       };

       "cpu" = {
         format = "<span color='#ec407a' size='17250'>󰍛</span><span rise='2500'> {usage}%</span>";
         format-alt = "󰍛   {avg_frequency} GHz";
         interval = 55;
       };

       "pulseaudio" = {
         format = "<span color='#5c64f3' size='18400'>{icon}</span><span rise='2500'>  {volume}%</span>";
         format-muted = "<span size='17250' foreground='#f37061'>󰝟</span> {volume}%";
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
         on-click-right = ''${toggleSinks-sh}/bin/ToggleSinks'';
         on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
         on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
       };

        "custom/weather" = {
         format = "{}°";
         tooltip = true;
         interval = 600;
         exec = ''wttrbar --nerd --custom-indicator "<span size='15000'>{ICON}</span>  {weatherDesc} |  {temp_C}"'';
         return-type = "json";
       }; 
       
       "battery" = {
         battery = "BAT0";
         adapter = "ADP0";
         full-at = 99;
         states = {
           plugged = 100;
           full = 99;
           good = 60;
           warning = 30;
           critical = 15;
         };
         format = "<span color='#f2a272' size='16000'>{icon}</span><span rise='2500'> {capacity}%</span>";
         format-charging = "<span color='#a7aa1a' size='15000'></span><span rise='2500'> {capacity}%</span>";
         format-plugged = "<span color='#85fe92' size='15000'>󰚥</span><span rise='2500'> {capacity}%</span>";
         format-full = "<span color='#85fe92' size='15000'></span><span rise='2500'> {capacity}%</span>";
         format-icons = [ "" "" "" "" "" ];
         tooltip-format = "{timeTo} - {capacity}%\nPower: {power}W";
         on-click = "sudo tlp fullcharge";
       };

       "clock" = {
         interval = 1;
         format = " {:%a  %B %d  <span color='#8897f4' size='14950'>󰥔</span>  %H:%M}";
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
         on-scroll-up = wsPrev;
         on-scroll-down = wsNext;
         format = "{icon}";
         # on-click = "activate";  # broken on Waybar 0.15 + Lua dispatcher
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
         format = "<span size='17250'>{icon}</span>  {volume}%";
         format-muted = "<span size='17250' foreground='#f37061'>󰝟</span>  {volume}%";
         format-icons = {
           headphone = " ";
           hands-free = "";
           headset = " ";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = ''${toggleSinks-sh}/bin/ToggleSinks'';
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
         on-scroll-up = wsPrev;
         on-scroll-down = wsNext;
         format = "{icon}";
         # on-click = "activate";  # broken on Waybar 0.15 + Lua dispatcher
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
           spotify_player = "<span size='14950' color='#1DB954'></span>";
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
         format = "<span size='18400'>{icon}</span>  {volume}%";
         format-muted = "<span size='18400' foreground='#f37061'>󰝟</span>  {volume}%";
         format-icons = {
           headphone = " ";
           hands-free = "";
           headset = " ";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = ''${toggleSinks-sh}/bin/ToggleSinks'';
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
         exec = ''wttrbar --nerd --custom-indicator "{ICON}   {temp_C}"'';
         return-type = "json";
       }; 
     };
   };
 };
}
