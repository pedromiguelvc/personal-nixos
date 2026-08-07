{
  programs.kitty = {
    enable = true;

    font = {
      name = "0xProto Nerd Font";
      size = 12;
    };

    settings = {
      # Font
      bold_font = "0xProto Nerd Font Bold";
      italic_font = "0xProto Nerd Font Italic";
      modify_font = "cell_height 122%";

      # Cursor
      cursor_shape = "underline";
      cursor_underline_thickness = 2.0;
      cursor_blink_interval = -1;
      cursor_stop_blinking_after = 0;

      # Colors
      background = "#140D20";
      foreground = "#F6E4CD";
      selection_background = "#35294E";
      selection_foreground = "#F6E4CD";

      color0 = "#1E1730";
      color1 = "#EF6F7A";
      color2 = "#79DBA0";
      color3 = "#EFC479";
      color4 = "#7C8AF0";
      color5 = "#EC84C0";
      color6 = "#6FD3D3";
      color7 = "#C9BEAF";

      color8 = "#6C6484";
      color9 = "#FF8A94";
      color10 = "#9DEBB8";
      color11 = "#FFD98F";
      color12 = "#9AA8FF";
      color13 = "#FF9FD3";
      color14 = "#8CF0F0";
      color15 = "#F6E4CD";

      # General
      allow_remote_control = "yes";
      term = "xterm-kitty";

      # Window
      background_opacity = "0.90";
      window_padding_width = "8 14";

      # Mouse / shell
      hide_cursor_when_typing = "yes";
      shell_integration = "no-cursor";
      enable_audio_bell = "no";
    };
  };
}
