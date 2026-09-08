{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a"; # 前缀键 Ctrl+a
    mouse = true; # 启用鼠标
    keyMode = "vi"; # vi 模式
    baseIndex = 1; # 窗口和 pane 从 1 开始
    clock24 = true; # 状态栏 24 小时制
    reverseSplit = false; # 分屏不翻转
    escapeTime = 0; # 消除 Neovim Esc 延迟
    historyLimit = 50000; # 增加滚动历史

    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    extraConfig = "
      set -g status-left-length 50
      set -g set-clipboard on
      set -g automatic-rename off
    ";
  };

  # 主题
  catppuccin.tmux = {
    enable = true;
    flavor = "mocha";
  };
}
