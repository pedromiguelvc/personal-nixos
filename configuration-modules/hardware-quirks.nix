# Workarounds for this laptop (Dell Inspiron 5402); review them when the hardware changes.
{
  boot = {
    blacklistedKernelModules = [
      # intel_oc_wdt keeps counting during suspend and resets the laptop; iTCO_wdt pauses itself.
      "intel_oc_wdt"
      # nouveau oopses probing the unused MX330 on 6.18.64 and the stuck probe hangs every suspend.
      "nouveau"
    ];

    # USB autosuspend makes the Bluetooth adapter drop off.
    extraModprobeConfig = "options btusb enable_autosuspend=n";
  };
}
