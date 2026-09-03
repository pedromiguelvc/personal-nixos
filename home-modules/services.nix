{ config, ... }:

{
  services = {
    swaync = {
      enable = true;
      settings = {
        notification-icon-size = 32;
        notification-body-image-height = 80;
        notification-body-image-width = 120;

        fit-to-screen = false;
        notification-window-preferred-output = "eDP-1";
        control-center-preferred-output = "eDP-1";
        positionY = "bottom";
        control-center-width = 350;
        control-center-height = 500;
        control-center-margin-top = 10;
        control-center-margin-bottom = 10;
        control-center-margin-right = 10;
        control-center-margin-left = 10;
      };
    };

    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 600;
            on-timeout = "brightnessctl -s set 15";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 900;
            on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
            on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && brightnessctl -r";
          }
          {
            timeout = 1200;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";

          }
          {
            timeout = 10800;
            on-timeout = "systemctl poweroff";
          }
        ];
      };
    };

    hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "eDP-1";
            path = "${config.home.homeDirectory}/Pictures/wallpaper-eDP-1";
            fit_mode = "cover";
          }
          {
            monitor = "HDMI-A-1";
            path = "${config.home.homeDirectory}/Pictures/wallpaper-HDMI-A-1";
            fit_mode = "cover";
          }
        ];
      };
    };
  };
}
