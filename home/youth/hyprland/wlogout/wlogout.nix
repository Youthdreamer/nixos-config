{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wlogout
  ];

  programs.wlogout.enable = true;

  # 定义 wlogout 的按钮布局
  programs.wlogout.layout = [
    # 锁屏
    {
      label = "lock";
      action = "hyprlock";
      text = "锁屏";
      keybind = "l";
    }
    # 注销
    {
      label = "logout";
      # 使用 loginctl terminate-user $USER 来注销
      action = "loginctl terminate-user ${config.home.username}";
      text = "注销";
      keybind = "e";
    }
    # 重启
    {
      label = "reboot";
      action = "systemctl reboot";
      text = "重启";
      keybind = "r";
    }
    # 关机
    {
      label = "shutdown";
      action = "systemctl poweroff";
      text = "关机";
      keybind = "s";
    }
  ];
  programs.wlogout.style = ''
    * {
      background-image: none;
      box-shadow: none;
    }

    window {
      background: linear-gradient(145deg, rgba(15, 15, 105, 0.3), rgba(6, 6, 6, 0.4));
      font-size: 0px;
    }

    /* ===== 按钮基础样式 ===== */
    button {
      background-color: transparent;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 40%;
      padding: 0px 10px;
      border: 2px solid transparent;
      transition: all 300ms ease-out;
      animation-timing-function: steps(24);
    }

    /* ===== 按钮悬停/焦点效果 ===== */
    button:active,
    button:hover {
      font-size: 30px;
      color: white;
      padding: 0px 40px;
      margin: 10px 0px 10px 0px;
      border-radius: 25px;
      border-color: rgba(255, 255, 255, 0.6);
      box-shadow: inset 0 0 10px rgba(255, 255, 255, 0.5);
      background-color: transparent;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 45%;
      transition: all 0.3s ease-out;
      animation-timing-function: steps(24);
    }

    /* ===== 按钮大小调整 ===== */
    #lock {
      margin: 40px 20px 40px 20px;
      padding: 0px 10px;
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
    }

    #reboot {
      margin: 40px 20px 40px 20px;
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
    }

    #logout {
      margin: 40px 20px 40px 20px;
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
    }

    #shutdown {
      margin: 40px 20px 40px 20px;
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
    }
  '';
}
