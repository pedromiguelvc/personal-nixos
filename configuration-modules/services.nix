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

    kanata = {
      enable = true;
      keyboards.default = {
        extraDefCfg = ''
          process-unmapped-keys yes
          tap-hold-require-prior-idle 150
        '';
        config = ''
          (defsrc
            esc caps a s d f h j k l ;
          )
          (defvar
            tap-time  200
            hold-time 220
            left-hand-keys  (q w e r t a s d f g z x c v b)
            right-hand-keys (y u i o p h j k l ; n m , . /)
          )
          (deflayer base
            caps @cap @a @s @d @f h @j @k @l @;
          )
          (deflayer nomods
            caps @cap a s d f h j k l ;
          )
          (deflayer nav
            caps XX lmet lalt lctl lsft left down up rght XX
          )
          (deffakekeys
            to-base (layer-switch base)
          )
          (defalias
            tap (multi
              (layer-switch nomods)
              (on-idle-fakekey to-base tap 150)
            )
            cap (tap-hold-press 200 200 esc (layer-while-held nav))
            a (tap-hold-release-keys $tap-time $hold-time (multi a @tap) lmet $left-hand-keys)
            s (tap-hold-release-keys $tap-time $hold-time (multi s @tap) lalt $left-hand-keys)
            d (tap-hold-release-keys $tap-time $hold-time (multi d @tap) lctl $left-hand-keys)
            f (tap-hold-release-keys $tap-time $hold-time (multi f @tap) lsft $left-hand-keys)
            j (tap-hold-release-keys $tap-time $hold-time (multi j @tap) rsft $right-hand-keys)
            k (tap-hold-release-keys $tap-time $hold-time (multi k @tap) rctl $right-hand-keys)
            l (tap-hold-release-keys $tap-time $hold-time (multi l @tap) lalt $right-hand-keys)
            ; (tap-hold-release-keys $tap-time $hold-time (multi ; @tap) rmet $right-hand-keys)
          )
        '';
      };
    };

  };
}
