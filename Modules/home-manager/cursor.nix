{ lib, pkgs, ... }:
{
  home.pointerCursor = {
    name = "Mini-Sleek";
    size = 24;
    package = pkgs.your-cursor-package; # or a local path
    gtk.enable = true;
    x11.enable = true;
  };
}
