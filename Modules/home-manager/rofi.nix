{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = 
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "#configuration" = {
          modi = "drun,ssh";
          display-drun = "";
          display-ssh = "";
          drun-display-format = "{name}";
          window-format = "{w} . {c} . {t}";
        };
        "#window" = {
          transparency = "real";
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          border = mkLiteral "2px";
          border-color = mkLiteral "@foreground";
          fullscreen = mkLiteral "false";
          width = mkLiteral "800px";
          x-offset = mkLiteral "0px";
          y-offset = mkLiteral "0px";
        };
        "#mainbox" = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "0px";
          bakcground-color = mkLiteral "transparent";
          orientation = mkLiteral "vertical";
          children = map mkLiteral [ "inputbar" "listbox" ];
        };
        "#listbox" = {
          spacing = mkLiteral "20px";
          padding = mkLiteral "20px"; 
          background-color = mkLiteral "transparent";
          orientation = mkLiteral  "vertical";
          border = mkLiteral "2px 0px 0px 0px";
          border-color = mkLiteral "@foreground";
          children = map mkLiteral [ "message" "listview" ];
        };
        "#inputbar" = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "10px";
          padding = mkLiteral "100px 60px";
          background-color = mkLiteral "transparent";
          background-image = mkLiteral "url(\"/home/Nuuvv/.config/Nixos/Modules/home-manager/Wallpapers/japan-night-painting-4k.png\", width)";
          text-color = mkLiteral "@foreground";
          orientation = mkLiteral "horizontal";
          children = map mkLiteral [ "textbox-prompt-colon" "entry" "dummy" "mode-switcher" ];
        };
        "#textbox-prompt-colon" = {
          enabled = mkLiteral "true";
          expand = mkLiteral "false";
          str = "";
          padding = mkLiteral "12px 15px";
          border-radius = mkLiteral "15px 5px 15px 5px";
          text-color = mkLiteral "inherit";
          size = mkLiteral "40px";
        };
        "#entry" = {
          enabled = mkLiteral "true";
          expand = mkLiteral "false";
          width = mkLiteral "250px";
          padding = mkLiteral "12px 16px";
          border-radius = mkLiteral "5px 15px 5px 15px";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "text";
          placeholder = "Search";
          placeholder-color = mkLiteral "inherit";
        };
        "#dummy" = {
          expand = mkLiteral "true";
          background-color = mkLiteral "transparent";
        };
        "#listview" = {
          enabled = mkLiteral "true";
          columns = mkLiteral "2";
          lines = mkLiteral "6";
          cycle = mkLiteral "true";
          dynamic = mkLiteral "true";
          scrollbar = mkLiteral "false";
          layout = mkLiteral "vertical";
          reverse = mkLiteral "false";
          fixed-height = mkLiteral "true";
          fixed-columns = mkLiteral "true";
          spacing = mkLiteral "10px";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
          cursor = "default";
        };
        "#element" = {
          enabled = mkLiteral "true";
          spacing = mkLiteral "10px";
          padding = mkLiteral "12px";
          border-radius = mkLiteral "15px 5px 15px 5px";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground";
          cursor = mkLiteral "pointer";
        };
        "#element normal.normal" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "#element normal.urgent" = {
          background-color = mkLiteral "@urgent";
          text-color = mkLiteral "@foreground";
        };
        "#element normal.active" = {
          background-color = mkLiteral "@active";
          text-color = mkLiteral "@foreground";
        };
        "#element selected.normal" = {
          background-color = mkLiteral "@selected";
          text-color = mkLiteral "@background";
        };
        "#element selected.urgent" = {
          background-color = mkLiteral "@urgent";
          text-color = mkLiteral "@foreground";
        };
        "#element selected.active" = {
          background-color = mkLiteral "@urgent";
          text-color = mkLiteral "@foreground";
        };
        "#element-icon" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          size = mkLiteral "32px";
          cursor = mkLiteral "inherit";
        };
        "#element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        "#message" = {
          background-color = mkLiteral "transparent";
        };
        "#textbox" = {
          padding = mkLiteral "12px";
          border-radius = mkLiteral "15px 5px 15px 5px";
          text-color = mkLiteral "@foreground";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        "#error-message" = {
          padding = mkLiteral "12px";
          border-radius = mkLiteral "0px";
          background-color = mkLiteral "@background";
          text-color = mkLiteral "@foreground";
        };
      
    };
  };  
}
