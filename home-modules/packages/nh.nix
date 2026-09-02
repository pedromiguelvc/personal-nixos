{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-sice 4d --keep 3";
    };
    flake = "home/carburauto/nixos";
  };
}
