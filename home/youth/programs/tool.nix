{pkgs, ...}: {
  home.packages = with pkgs; [
    tty-clock
    tree
    unzip
    zip
    tldr
    entr

    wlr-randr

    # 缩略图
    imagemagick
    # 截图
    grim
    slurp
    # 截图后编辑
    satty
    # 录制
    wf-recorder
    # 剪切板
    wl-clipboard
    cliphist
    #远程桌面
    wayvnc
    # 蓝牙
    blueman
  ];

  # fzf 模糊搜索 主题
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultCommand = "fd --type f";
    defaultOptions = [
      "--preview '[ -d {} ] && eza --tree --level=2 --color=always {} || bat --color=always --style=numbers {}'"
      "--preview-window=right:60%"
    ];

    changeDirWidgetOptions = [
      "--preview '[ -d {} ] && eza --tree --level=2 --color=always {} || eza --color=always {}'"
      "--preview-window=right:40%"
    ];

    historyWidgetOptions = [
      "--no-preview"
    ];
  };
  catppuccin.fzf = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  # fd查找
  programs.fd = {
    enable = true;
    hidden = true; # 搜索隐藏文件
    ignores = ["node_modules" "target"];
  };

  # ripgrep/ripgrpe-all 更快的查询
  programs.ripgrep.enable = true;
  programs.ripgrep-all.enable = true;

  # eza(exa)文件查看
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    colors = "auto";
    git = true;
    icons = "auto";
  };

  # bat文件内容查看 主题
  programs.bat = {
    enable = true;
    config = {
      number = true;
      paging = "always";
    };
  };
  catppuccin.bat = {
    enable = true;
    flavor = "mocha";
  };

  # jq json查看
  programs.jq.enable = true;

  # imv图片查看 主题
  programs.imv.enable = true;
  catppuccin.imv = {
    enable = true;
    flavor = "mocha";
  };

  # yazi终端文件管理 主题
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  # zoxide智能目录跳转
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # btop系统监控 主题
  programs.btop.enable = true;
  catppuccin.btop = {
    enable = true;
    flavor = "mocha";
  };

  # cava频谱 主题
  programs.cava.enable = true;
  catppuccin.cava = {
    enable = true;
    flavor = "mocha";
    transparent = true;
  };
}
