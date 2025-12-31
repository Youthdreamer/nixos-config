{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi-wayland
  ];
 
  home.file.".config/rofi/config.rasi".source = ./config.rasi;
  home.file.".config/rofi/themes/custom-theme.rasi".source = ./themes/custom-theme.rasi;
  home.file.".config/rofi/themes/wallpaper_2_line.rasi".source = ./themes/wallpaper_2_line.rasi;
  home.file.".config/rofi/themes/screenshot.rasi".source = ./themes/screenshot.rasi;
  home.file.".config/rofi/themes/app.rasi".source = ./themes/app.rasi;

}
