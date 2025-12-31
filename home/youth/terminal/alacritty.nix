{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
  };

  programs.alacritty.settings = {
    font = {
      normal.family = "FiraCode Nerd Font";
      normal.style  = "Regular";
      size = 14.0;
    };
  };

  catppuccin.alacritty = {
    enable = true;
    flavor = "mocha";
  };

}
