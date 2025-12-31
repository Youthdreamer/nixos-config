_: {
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 14;
    };
    extraConfig = ''
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      background_opacity 0.92
      background_blur 30
      hide_window_decorations yes
      confirm_os_window_close 0
      tab_bar_edge bottom
      tab_bar_min_tabs 1
      tab_bar_style powerline
      tab_powerline_style slanted
      inactive_tab_foreground #CDD6F4
      inactive_tab_background #1E1E2E
      tab_title_template " {index}: {title}{'  {}'.format(num_windows) if num_windows > 1 else \'\'}"
      active_tab_foreground #11111B
      active_tab_background #CBA6F7
      inactive_tab_foreground #CDD6F4
      selection_foreground none
      selection_background #585B70
      remember_window_size yes
      force_ltr_rendering yes
      disable_ligature
    '';
    themeFile = "Catppuccin-Mocha";
  };
}
