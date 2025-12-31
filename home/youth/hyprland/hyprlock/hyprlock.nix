{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
  ];
  
  programs.hyprlock.enable = true;

  home.file."/.config/hypr/hyprlock.conf".source = ./hyprlock.conf;
}
