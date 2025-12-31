{ config, pkgs, inputs, ... }:
{
  
  # 手动启动
  programs.noctalia-shell.systemd.enable = false;
  programs.noctalia-shell.enable = true;
}
