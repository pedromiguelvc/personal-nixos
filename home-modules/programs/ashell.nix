{
  programs.ashell = {
    enable = true;

    systemd = {
      enable = true;
      target = "hyrpland-session.target";
    };

    settings = {
      log_level = "warn";

      position = "Bottom";
      outputs = "All";

      modules = {
        left = [
          "Tempo"
          "MediaPlayer"
        ];
        center = [ "Workspaces" ];
        right = [
          "SystemInfo"
          "Settings"
          "SwayncNotifications"
        ];
      };

      workspaces = {
        visibility_mode = "MonitorSpecificExclusive";
        group_by_monitor = true;
        enable_workspace_filling = false;
        max_workspaces = 10;
      };

      updates = {
        check_cmd = "checkupdates; paru -Qua";
        update_cmd = ''
          alacritty -e bash -c "paru; echo Done - Press enter to exit; read" &
        '';
        interval = 3600;
      };

      tempo = {
        clock_format = "%a %d %b %R";
      };

      system_info = {
        indicators = [
          "Cpu"
          "Memory"
          "Temperature"
        ];
        interval = 5;

        cpu = {
          warn_threshold = 60;
          alert_threshold = 80;
        };

        memory = {
          warn_threshold = 70;
          alert_threshold = 85;
          format = "Fraction";
        };

        temperature = {
          warn_threshold = 60;
          alert_threshold = 80;
          sensor = "coretemp Package id 0";
        };
      };

      media_player = {
        max_title_length = 30;
        indicator_format = "IconAndTitle";
      };

      notifications = {
        format = "%H:%M";
        show_timestamps = true;
        show_bodies = true;
        toast = true;
        grouped = true;
        toast_position = "bottom_right";
        toast_timeout = 2000;
      };

      settings = {
        lock_cmd = "playerctl --all-players pause; hyprlock &";
        logout_cmd = "loginctl kill-user $(whoami)";
        shutdown_cmd = "shutdown now";
        reboot_cmd = "systemctl reboot";
        suspend_cmd = "systemctl suspend";

        audio_sinks_more_cmd = "pavucontrol -t 3";
        audio_sources_more_cmd = "pavucontrol -t 4";
        audio_indicator_format = "IconAndPercentage";

        wifi_more_cmd = "nm-connection-editor";

        battery_format = "IconAndPercentage";
        bluetooth_indicator_format = "IconAndValue";
        brightness_indicator_format = "IconAndPercentage";

        indicators = [
          "PowerProfile"
          "Network"
          "Brightness"
          "Audio"
          "Battery"
        ];
      };

      osd = {
        enabled = true;
        timeout = 1500;
        show_volume_percentage = true;
        show_brightness_percentage = true;
      };

      animations = {
        enabled = true;
      };

      appearance = {
        style = "Islands";
        font_name = "Ubuntu Nerd Font";

        primary_color = "#7aa2f7";
        success_color = "#9ece6a";
        warning_color = "#e0af68";
        danger_color = "#f7768e";
        text_color = "#c0caf5";

        workspace_colors = [
          "#7aa2f7"
          "#9ece6a"
        ];

        background_color = {
          base = "#1a1b26";
          weak = "#24283b";
          strong = "#414868";
        };

        menu = {
          opacity = 0.7;
        };
      };

      CustomModule = [
        {
          name = "SwayncNotifications";
          type = "Button";
          icon = "󰂚";
          command = "swaync-client -t -sw";
          listen_cmd = "swaync-client -swb";

          icons = {
            "^dnd-none$" = "󰂛";
            "^dnd-notification$" = "󰪑";
            "^notification$" = "󱅫";
            "^none$" = "󰂚";
          };

          alert = "notification";
        }
      ];
    };
  };
}
