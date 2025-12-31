{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];

  home.file.".p10k.zsh" = {
    source = ./p10k.zsh;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
    };
  };
  home.shell.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      nv = "nvim";
      snv = "sudo nvim";
      ff = "fastfetch";
      nlg = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      ncg = "sudo nix-collect-garbage -d"; # 清理无用包
    };
    #    使用P10K打开下面以下注释
    initContent = ''
      # source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      # [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      for file in /run/agenix/ai_api_key.zsh; do
        [ -f "$file" ] && source "$file"
      done
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
  };
}
