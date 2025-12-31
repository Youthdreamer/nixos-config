{ config, pkgs, inputs, ...}:
{
  programs.lazygit = { 
    enable = true;
    settings = {};
  };

  catppuccin.lazygit = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };
}
