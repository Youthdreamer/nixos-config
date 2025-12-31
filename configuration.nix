{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  environment.systemPackages = with pkgs; [
    pulseaudio
    pciutils # lspci
    ffmpeg
    libva
    libva-utils
    power-profiles-daemon
    vim
    git
    curl
    wget
    bluez
  ];

  # docker
  virtualisation.docker.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    TERMINAL = "kitty";
  };

  # NOTE: 敏感环境变量加载 (ai_api_key等)
  age.identityPaths = [
    "/home/youth/.ssh/id_ed25519"
  ];
  age.secrets."ai_api_key.zsh" = {
    file = ./secrets/ai_api_key.age;
    owner = "youth";
  };

  programs.zsh.enable = true;
  users.users.youth = {
    description = "Youth";
    isNormalUser = true;
    home = "/home/youth";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    hashedPassword = "$6$d89dDb.7HKl8dx2J$NP00uF4ukMaVYoWzInQxoeokT7927qybXJGzrGwe7WYd7aRNMrNVfLbgnotRDPysU0lqTrZ1L0uTu7EjXsYwg/";
    extraGroups = ["wheel" "networkmanager" "audio" "video" "docker" "kvm" "libvirtd"];
  };
  security.sudo.wheelNeedsPassword = false; # sudo组是否需要密码

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Low-power CPUs use the kernel parameters below to avoid crashes
  boot.kernelParams = ["ahci.mobile_lpm_policy=1"];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.timesyncd.enable = true;

  # U盘自动加载
  services.udisks2.enable = true;

  # networking
  networking.hostName = "cook";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    5900
  ];

  # Configure network proxy if necessary
  # 系统级代理设置
  networking.proxy = {
    default = "http://127.0.0.1:7897";
    httpProxy = "http://127.0.0.1:7897";
    httpsProxy = "http://127.0.0.1:7897";
    noProxy = "localhost,127.0.0.1,::1,*.local";
  };

  # networking.proxy = {
  #   default = "http://192.168.3.90:7897";
  #   httpProxy = "http://192.168.3.90:7897";
  #   httpsProxy = "http://192.168.3.90:7897";
  #   noProxy = "localhost,127.0.0.1,::1,*.local";
  # };
  # 禁用所有形式的睡眠和休眠
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes         # 如果只想禁用休眠，可以保持 Suspend 启用
    AllowHibernation=no      # 禁用休眠 (Hibernate)
    AllowHybridSleep=no      # 禁用混合睡眠 (Hybrid Sleep)
    AllowSuspendThenHibernate=no # 禁用先睡眠后休眠
  '';

  # timezone and local
  time.timeZone = "Asia/Shanghai";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_CTYPE = "zh_CN.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  programs.steam.enable = true;
  programs.steam.fontPackages = with pkgs; [source-han-sans];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Sans" "Noto Sans CJK SC"];
        sansSerif = ["Noto Serif" "Noto Serif CJK SC"];
        monospace = ["Fira Code"];
      };
    };
  };

  # Niri
  programs.niri.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  # services.displayManager.sddm.enable = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Enable sound.
  services.pulseaudio.enable = false;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  hardware = {
    enableAllFirmware = true; # 自动安装所有固件
    cpu.intel.updateMicrocode = true; # Intel CPU
    # cpu.amd.updateMicrocode = true; # AMD CPU
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };
  system.stateVersion = "25.05";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
