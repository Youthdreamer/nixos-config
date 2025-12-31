{ config, pkgs, inputs, ... }:
{
  # 选择输入法类型为 fcitx5
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
  };

  # 添加常用中文模块
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-rime
    fcitx5-configtool
    fcitx5-chinese-addons  # 拼音、五笔等
  ];

  /*
   *i18n.inputMethod.fcitx5.settings.inputMethod与catppuccin.fcitx5.apply相冲突
   *因为两者都试图管理同一个配置文件
   *catppuccin.fcitx5可以导入主题配色可以使用classicui.globalSection.Theme导入主题
   *也可以禁用inputMethod，设置主题。
  */

  # 设置rime输入法与美式键盘英文输入法并排序rime第一位
  i18n.inputMethod.fcitx5.settings.inputMethod = {
    GroupOrder."0" = "Default";
    "Groups/0" = {
      Name = "Default";
      "Default Layout" = "us";
      DefaultIM = "keyboard-us";
    };
    "Groups/0/Items/0".Name = "keyboard-us";
    "Groups/0/Items/1".Name = "rime";
  };

  i18n.inputMethod.fcitx5.settings.addons = {
    classicui.globalSection.Theme = "catppuccin-mocha-mauve";
  };
  
  # catppuccin的flake,option
  catppuccin.fcitx5 = {
    enable = true;
    flavor = "mocha";      # 主题变体
    accent = "mauve";      # 强调色
    enableRounded = true;  # 启用圆角
    apply = false;          # 自动配置
  };
}

