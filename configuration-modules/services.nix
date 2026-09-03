{
  services = {
    openssh.enable = true; # Enable the OpenSSH daemon.
    blueman.enable = true;
    upower.enable = true;
    fwupd.enable = true;
    udisks2.enable = true;

    displayManager = {
      gdm.enable = true;
      defaultSession = "hyprland-uwsm";
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            esc = "capslock";
          };
        };
      };
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "balanced";
          turbo = "auto";
        };
      };
    };
  };
}
