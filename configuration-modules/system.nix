{
  boot = {
    kernel.sysctl = {
      "kernel.sysrq" = 1;
      "kernel.softlockup_panic" = 1;
      "kernel.hardlockup_panic" = 1;
      "kernel.panic" = 10;
    };
    blacklistedKernelModules = [ "intel_oc_wdt" ]; # intel_oc_wdt keeps counting during suspend and resets the laptop; iTCO_wdt pauses itself.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    extraModprobeConfig = "options btusb enable_autosuspend=n";
  };

  systemd = {
    oomd.enable = true;
    settings.Manager = {
      RuntimeWatchdogSec = "60s";
      RebootWatchdogSec = "5min";
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  zramSwap.enable = true;
  security.rtkit.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true; # NOT SUPPORTED BY FLAKE

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
