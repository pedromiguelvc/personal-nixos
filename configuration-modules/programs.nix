{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

}
