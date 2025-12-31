{ config, pkgs, ... }:
{
  programs.fuzzel.enable = true;
  catppuccin.fuzzel = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };

  home.file.".config/niri/config.kdl".source = ./config.kdl;

}
