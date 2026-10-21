{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    btop
    curl
    eza
    fd
    jq
    ripgrep
    trash-cli
    cava
    inotify-tools
    wl-clipboard
    gcc
    gnumake
    yazi
    procps
    wlogout
    fastfetch
    cliphist
    libnotify

    lua-language-server
    nil
    nixfmt
    luarocks
    stylua
    tree-sitter
    gh
    tuicr

    brave
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    hyprtoolkit
  ];
}
