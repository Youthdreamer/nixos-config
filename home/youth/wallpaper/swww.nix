{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
  ];
  
  home.file.".config/wallpaper" = {
    source = ./image;
    recursive = true;
  };

}
