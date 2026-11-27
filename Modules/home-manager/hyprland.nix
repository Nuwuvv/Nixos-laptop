{ config, pkgs, lib, ... }:
# Hyprland (>= 0.55, Lua config) via Home Manager.
# Each top-level attribute in `settings` becomes an hl.<name>(...) call;
# lists become one call per element; `_args` = multi-argument call.
let
  # Startup script — launched once by the hyprland.start event below.
  # (The old `hyprctl dispatch workspace 1` moved into the Lua callback.)
  start-sh = pkgs.writeShellScriptBin "start" ''
    hyprpaper &
    dunst &
    hyprctl setcursor Duccursor 1 &
    hypridle &
    waybar
  '';

  mod         = "SUPER";
  terminal    = "kitty -1";
  fileManager = "dolphin";
  menu        = "rofi -show drun -show-icons";

  # Helpers so the Lua encoding isn't spelled out on every line.
  lua    = lib.generators.mkLuaInline;
  bind   = key: dsp:        { _args = [ key (lua dsp) ]; };        # hl.bind(key, dsp)
  bindf  = key: dsp: flags: { _args = [ key (lua dsp) flags ]; };  # hl.bind(key, dsp, { flags })
  exec   = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
  envv   = name: value: { _args = [ name value ]; };               # hl.env(name, value)
  bezier = name: pts: { _args = [ name (lua ''{ type = "bezier", points = { ${pts} } }'') ]; };
  anim   = leaf: speed: curve: extra:
    { inherit leaf speed; enabled = true; bezier = curve; } // extra;

  # SUPER+1..0 -> workspace N, SUPER+SHIFT+1..0 -> move window to N
  workspaceBinds = lib.concatMap (i:
    let k = toString (lib.mod i 10); n = toString i; in [
      (bind "${mod} + ${k}"         "hl.dsp.focus({ workspace = ${n} })")
      (bind "${mod} + SHIFT + ${k}" "hl.dsp.window.move({ workspace = ${n} })")
    ]) (lib.range 1 10);
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      # was: monitor = ", preferred, auto, 1"  (catch-all for any output)
      monitor = { output = ""; mode = "preferred"; position = "auto"; scale = 1; };

      env = [
        # (envv "HYPRCURSOR_SIZE" "24")
        (envv "HYPRCURSOR_THEME" "Mini-Sleek")
        (envv "WLR_NO_HARDWARE_CURSORS" "1")
        (envv "XCURSOR_THEME" "Mini-Sleek")
        (envv "XCURSOR_SIZE" "24")
      ];

      # was exec-once
      on = [{
        _args = [ "hyprland.start" (lua ''
          function()
            hl.exec_cmd("${start-sh}/bin/start")
            hl.dispatch(hl.dsp.focus({ workspace = 1 }))
          end
        '') ];
      }];

      config = {
        ecosystem.no_update_news = true;

        general = {
          gaps_in = 3;
          gaps_out = { top = 2; right = 5; bottom = 6; left = 5; };
          border_size = 0;
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 0.9;
          shadow = { enabled = true; range = 4; render_power = 3; };
          blur   = { enabled = true; size = 3; passes = 1; vibrancy = 0.1696; };
        };

        animations.enabled = true;

        dwindle.preserve_split = true; # `pseudotile` option was removed in 0.55; SUPER+P still toggles it
        master.new_status = "master";
        misc.force_default_wallpaper = -1;

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad.natural_scroll = false;
        };
      };

      # was bezier = ...
      curve = [
        (bezier "easeOutQuint"   "{0.23, 1}, {0.32, 1}")
        (bezier "easeInOutCubic" "{0.65, 0.05}, {0.36, 1}")
        (bezier "linear"         "{0, 0}, {1, 1}")
        (bezier "almostLinear"   "{0.5, 0.5}, {0.75, 1.0}")
        (bezier "quick"          "{0.15, 0}, {0.1, 1}")
      ];

      # was animation = leaf, 1, speed, curve[, style]
      animation = [
        (anim "global"        10   "default"      {})
        (anim "border"        5.39 "easeOutQuint" {})
        (anim "windows"       4.79 "easeOutQuint" {})
        (anim "windowsIn"     4.1  "easeOutQuint" { style = "popin 87%"; })
        (anim "windowsOut"    1.49 "linear"       { style = "popin 87%"; })
        (anim "fadeIn"        1.73 "almostLinear" {})
        (anim "fadeOut"       1.46 "almostLinear" {})
        (anim "fade"          3.03 "quick"        {})
        (anim "layers"        3.81 "easeOutQuint" {})
        (anim "layersIn"      4    "easeOutQuint" { style = "fade"; })
        (anim "layersOut"     1.5  "linear"       { style = "fade"; })
        (anim "fadeLayersIn"  1.79 "almostLinear" {})
        (anim "fadeLayersOut" 1.39 "almostLinear" {})
        (anim "workspaces"    1.94 "almostLinear" { style = "fade"; })
        (anim "workspacesIn"  1.21 "almostLinear" { style = "fade"; })
        (anim "workspacesOut" 1.94 "almostLinear" { style = "fade"; })
      ];

      bind = [
        (bind "${mod} + RETURN" (exec terminal))
        (bind "${mod} + Q"      "hl.dsp.window.close()")                # killactive
        (bind "${mod} + M"      "hl.dsp.exit()")
        (bind "${mod} + E"      (exec fileManager))
        (bind "${mod} + V"      ''hl.dsp.window.float({ action = "toggle" })'')
        (bind "${mod} + D"      (exec menu))
        (bind "${mod} + P"      "hl.dsp.window.pseudo()")
        (bind "${mod} + F"      ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'')
        (bind "${mod} + G"      ''hl.dsp.window.fullscreen({ mode = "maximized" })'')  # fullscreen, 1
        (bind "${mod} + T"      "hl.dsp.window.fullscreen_state({ internal = 0, client = 2 })")

        # movefocus
        (bind "${mod} + H" ''hl.dsp.focus({ direction = "left" })'')
        (bind "${mod} + L" ''hl.dsp.focus({ direction = "right" })'')
        (bind "${mod} + I" ''hl.dsp.focus({ direction = "up" })'')
        (bind "${mod} + J" ''hl.dsp.focus({ direction = "down" })'')

        # special workspace (scratchpad)
        (bind "${mod} + S"         ''hl.dsp.workspace.toggle_special("magic")'')
        (bind "${mod} + SHIFT + S" ''hl.dsp.window.move({ workspace = "special:magic" })'')

        # scroll through workspaces
        (bind "${mod} + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
        (bind "${mod} + mouse_up"   ''hl.dsp.focus({ workspace = "e-1" })'')

        # was bindm
        (bindf "${mod} + mouse:272" "hl.dsp.window.drag()"   { mouse = true; })
        (bindf "${mod} + mouse:273" "hl.dsp.window.resize()" { mouse = true; })

        # was bindel
        (bindf "XF86AudioRaiseVolume" (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") { repeating = true; locked = true; })
        (bindf "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")      { repeating = true; locked = true; })
        (bindf "XF86AudioMute"        (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")     { repeating = true; locked = true; })
        (bindf "XF86AudioMicMute"     (exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")   { repeating = true; locked = true; })
        (bindf "XF86MonBrightnessUp"   (exec "brightnessctl -e4 -n2 set 5%+") { repeating = true; locked = true; })
        (bindf "XF86MonBrightnessDown" (exec "brightnessctl -e4 -n2 set 5%-") { repeating = true; locked = true; })

        # was bindl
        (bindf "XF86AudioNext"  (exec "playerctl next")       { locked = true; })
        (bindf "XF86AudioPause" (exec "playerctl play-pause") { locked = true; })
        (bindf "XF86AudioPlay"  (exec "playerctl play-pause") { locked = true; })
        (bindf "XF86AudioPrev"  (exec "playerctl previous")   { locked = true; })
      ] ++ workspaceBinds;
    };
  };
}
