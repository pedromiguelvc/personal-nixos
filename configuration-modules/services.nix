{
  # List services that you want to enable:

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services.openssh.enable = true; # Enable the OpenSSH daemon.
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.blueman.enable = true;
  services.upower.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
        };
      };
    };
  };
  services.auto-cpufreq = {
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
}
