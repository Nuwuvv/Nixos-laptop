{ config, pkgs, ... }:
{
 programs.waybar.style = {
   ''
     * {
       border: none;
       border-radius: 0px;
       font-size: 15px;
       sont-style: normal;
       min-height: 0;
     }
   ''
 };
}
