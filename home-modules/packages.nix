{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    btop
    curl
    eza
    fd
    jq
    gh
    ripgrep
    trash-cli
    wl-clipboard
    gcc
    gnumake
    yazi
    procps
    wlogout
    fastfetch
    cliphist
    libnotify
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    hyprtoolkit
  ];
}
