{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    google-chrome
    vlc
    discord
    obsidian
    youtube-music
    spotify
    kdePackages.dolphin
    pkgs-unstable.clash-verge-rev
  ];

  # 谷歌浏览器设置 主题
  # programs.chromium = {
  #   enable = true;
  #   commandLineArgs = [
  #     "--force-dark-mode"
  #     "--enable-features=UseOzonePlatform"
  #     "--ozone-platform=wayland"
  #     "--force-device-scale-factor=1"
  #     "--enable-gpu-rasterization"
  #     "--enable-zero-copy"
  #   ];
  #   extensions = [
  #     "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
  #     "bpoadfkcbjbfhfodiogcnhhhpibjhbnh" # 沉浸式翻译
  #     "egehpkpgpgooebopjihjmnpejnjafefi" # Better History | 管理、导出与删除历史记录
  #     "kjoehdlockiihccmfnoamenhobkkddng" # CSDN自动展开+一键复制代码
  #   ];
  # };
  # catppuccin.chromium = {
  #   enable = true;
  #   flavor = "mocha";
  # };

  # firefox
  programs.firefox = {
    enable = true; # 安装并启用 Firefox
    languagePacks = ["zh-CN"]; # 中文语言包，可按需加其他
    profiles.default = {
      name = "default"; # 默认 profile 名称
      isDefault = true; # 设置为默认 profile
      settings = {
        "privacy.donottrackheader.enabled" = true; # 开启“请勿跟踪”
      };
    };
  };

  # 视频软件
  programs.mpv.enable = true;
  catppuccin.mpv = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };

  # 录制软件
  programs.obs-studio.enable = true;
}
