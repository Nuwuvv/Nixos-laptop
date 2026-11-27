{ config, pkgs, ... }:
{
 programs.waybar.style = ''
    * {
      border: none;
      border-radius: 0px;
      font-family: JetBrainsMono Nerd Fonts;
      font-style: normal;
      font-weight: normal;
      min-height: 0px;
      padding: 0px;
      margin: 0px;
    }
    
    tooltip {
      background-color: rgba(46,52,64,0.3);
      color: #f38986;
      border-radius: 16px;
      margin: 5px;
      padding: 0px 10px 0px 10px;
      font-weight: bold;
    }

    window#waybar {
      background: transparent;
    }
 
    #custom-launcher {
      color: #92b8cd;
      background-color: rgba(14,22,26,0.6);
      border: solid 2px rgba(31,29,41,0.2);
      border-radius: 8px;
      margin: 5px 4px 5px 5px;
      padding: 0px 12px 1px 12px;
      font-size: 29;
    }

    #G1 {
      background-color: rgba(14,22,26,0.6);
      margin: 5px 4px 5px 4px;
      padding: 4px 5px;
      border-radius: 8px;
      border: solid 2px rgba(31,29,41,0.2);
      font-weight: normal;
      font-style: normal;
    }
    
    #custom-Nix {
      color: rgba(253,253,253,1);
      font-size: 14px;
      padding-right: 15px;
      padding-left: 5px;
    }

    #workspaces {
      padding-left: 4px;
      padding-right: 10px;
    }

    #workspaces button {
      padding: 0px 5px;
      font-size: 19.5px;
      margin: 0px 3px;
      color: #6990c6;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button:hover {
      font-size: 23px;
      padding: 0px 10px;
      background: transparent;
    }
    #workspaces button:not(.active):nth-child(1):hover { color: #FF2D55; }
    #workspaces button:not(.active):nth-child(2):hover { color: #9B30FF; }
    #workspaces button:not(.active):nth-child(3):hover { color: #FF2D9B; }
    #workspaces button:not(.active):nth-child(4):hover { color: #00FF6A; }
    #workspaces button:not(.active):nth-child(5):hover { color: #00F5FF; }
    #workspaces button:not(.active):nth-child(6):hover { color: #FF6B00; }
    #workspaces button:not(.active):nth-child(7):hover { color: #FFE600; }

    #workspaces button.active {
      color: #f2a272;
      transition: all 0.3s ease-in-out;
    }

    #custom-vpn {
      padding-left: 9px;
      padding-right: 10px;
      font-size: 18.4px;
    }

    #custom-vpn.connected {
      color: #6ff28b;
    }

    #custom-vpn.disconnected {
      color: #4e4e4e;
    }

    #G2 {
      background-color: rgba(14,22,26,0.6);
      margin: 5px 4px 5px 4px;
      padding: 4px 5px;
      border-radius: 8px;
      border: solid 2px rgba(31,29,41,0.2);
      font-weight: normal;
      font-style: normal;
      min-width: 350px;
    }

    #backlight {
      margin: 0px 5px 0px 5px;
      padding: 0px 5px 0px 9px;
      font-size: 14px;
    }

    #cava {
      /*color: #cdd6f4;*/
      background-color: rgba(46,52,64,0.6);
      border-radius: 8px;
      padding: 0px 10px 0px 10px;
      margin: 5px 7px 5px 7px;
      border: solid 2px rgba(205,214,244,0.7);
      font-weight: bold;
      font-size: 20;
    } 

    #mpris {
      color: #FDFDFD;
      background-color: rgba(14,22,26,0.6);
      font-weight: normal;
      font-style: normal;
      border-radius: 8px;
      border: solid 2px rgba(31,29,41,0.2);
      margin: 5px 4px 5px 4px;
      padding: 0px 15px 0px 15px;
      font-size: 16px;
    }


    #bluetooth {
      color: #3924f3;
      margin: 0px 7px 0px 7px;
      font-size: 14px;
      padding: 0px 7px 0px 7px;
    }

    #tray {
      padding: 0px 10px 0px 10px;
    }

    #tray menu {
      background-color: rgba(46,52,64,0.5);
      border-radius: 14px;
      border: solid 1px rgba(205,214,244,0.7);
      padding: 5px;
    }

    #window {
      background: rgba(46,52,64,0.6);
      border: solid 2px rgba(205,214,244,0.7);
      padding-left: 15px;
      padding-right: 15px;
      border-radius: 8px;
      margin: 3px 0px 3px 0px;
      font-weight: normal;
      font-style: normal;
      font-size: 16;
    }

    #G3 {
      background-color: rgba(14,22,26,0.6);
      margin: 6px 4px 6px 4px;
      padding: 4px 5px;
      border-radius: 8px;
      border: solid 2px rgba(31,29,41,0.2);
      font-weight: normal;
      font-style: normal;
      min-width: 450px;
    }

    #network {
      color: #FDFDFD;
      padding: 0px 7px 0px 7px;
      font-size: 14px;
      min-width: 100px;
    }

    #custom-updates {
      color: #FDFDFD;
      margin: 0px 5px 0px 5px;
      padding: 0px 5px 0px 5px;
      font-size: 14px;
    }
      
    #disk {
      color: #DFDFDF;
      padding: 0px 9px 0px 7px;
      font-size: 14px;
    }

    #memory {
      color: #DFDFDF;
      padding: 0px 7px 0px 7px;
      font-size: 14px;
    }

    #cpu {   
      color: #DFDFDF;
      padding: 0px 7px 0px 7px;
      font-size: 14px;
    }

    #pulseaudio {
      color: #DFDFDF;
      padding: 0px 7px 0px 7px;
      font-size: 14px;
    }
    
    #battery {
      color: #DFDFDF;
      padding: 0px 7px 0px 9px;
      font-size: 14px;
    }

    #custom-weather {
      color: #FDFDFD;
      padding-left: 10px;
      padding-right: 10px;
      margin: 0px 5px 0px 5px;
      font-size: 15px;
    }

    #clock {
      color: #DFDFDF;
      border-radius: 8px;
      padding-left: 13px;
      padding-right: 15px;
      margin: 6px 5px 6px 4px;
      border: solid 2px rgba(31,29,41,0.2);
      font-weight: normal;
      font-style: normal;
      font-size: 14;
      background-color: rgba(14,22,26,0.6);
    }

  '';
}
