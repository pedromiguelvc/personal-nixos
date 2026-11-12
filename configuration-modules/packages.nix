{
  pkgs,
  ...
}:

{

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    unzip
    brightnessctl
    playerctl
    wget
    vim
  ];

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
      flake = "/home/carburauto/nixos";
    };

    nix-ld.enable = true;

    zsh.enable = true;

  };
}
