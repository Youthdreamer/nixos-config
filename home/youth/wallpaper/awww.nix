{pkgs, ...}: {
  home.packages = with pkgs; [
    awww
  ];

  home.file.".config/wallpaper" = {
    source = ./image;
    recursive = true;
  };
}
