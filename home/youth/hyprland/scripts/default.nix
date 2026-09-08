_: {
  #------- hyprland 录屏与截图快捷键脚本--------#
  home.file.".config/hypr/scripts/capture.sh" = {
    source = ./capture.sh;
    executable = true; # 设置可执行权限
  };

  #------------- 录制辨识 ------------#
  home.file.".config/waybar/scripts/wf-recorder-status.sh" = {
    source = ./wf-recorder-status.sh;
    executable = true; # ✅ 正确设置可执行权限
  };

  #---------壁纸切换脚本--------#
  home.file.".config/wallpaper/script/awww-rofi.sh" = {
    source = ./awww-rofi.sh;
    executable = true;
  };
}
