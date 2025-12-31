{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./shell
    ./programs
    ./terminal
    ./niri
    ./hyprland
    ./noctalia
    ./fcitx5
    ./rofi
    ./wallpaper
    ./music
  ];

  home.packages = with pkgs; [
    xwayland-satellite # xwayland support
    libnotify
  ];

  # 自动创建截图文件夹
  home.activation.ensureScreenshotDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.home.homeDirectory}/screenshot"
  '';

  services.polkit-gnome.enable = true; # 权限认证

  # 消息通知
  services.swaync.enable = true;
  services.swayidle.enable = true;
  catppuccin.swaync = {
    enable = true;
    flavor = "mocha";
  };

  # services.mako.enable = true;
  # catppuccin.mako = {
  #   enable = true;
  #   accent = "mauve";
  #   flavor = "mocha";
  # };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "image/png" = ["imv.desktop"];
    "image/jpeg" = ["imv.desktop"];
    "image/gif" = ["imv.desktop"];
    "text/html" = ["chromium-browser.desktop"];
    "x-scheme-handler/clash" = "clash-verge.desktop";
  };

  # 光标配置
  home.pointerCursor = {
    enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8"; # 系统主语言英文
    LC_CTYPE = "zh_CN.UTF-8"; # 字符显示支持中文
    LC_MESSAGES = "en_US.UTF-8"; # 程序输出信息保持英文
    GTK_IM_MODULE = lib.mkForce "";
  };

  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;
}
