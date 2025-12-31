{pkgs-unstable, ...}: {
  programs.neovide.enable = true;
  programs.neovide.package = pkgs-unstable.neovide;
  programs.neovide.settings = {
    idle = true;
    vsync = true;

    font = {
      normal = [];
      size = 16.0;
    };
  };
}
