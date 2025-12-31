{pkgs, ...}: {
  imports = [
    ./scripts
    ./waybar/waybar.nix
    ./wlogout/wlogout.nix
    ./hyprlock/hyprlock.nix
  ];

  home.packages = with pkgs; [
    hyprland
  ];

  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  #  polkit 身份验证守护 GUI 应用程序需要能够请求提升的权限
  # services.hyprpolkitagent.enable = true;
  # services.hyprpolkitagent.package = pkgs.hyprpolkitagent;
}
