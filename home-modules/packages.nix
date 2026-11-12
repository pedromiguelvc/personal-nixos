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
    nixd
    nixfmt
    luarocks
    stylua
    tree-sitter
    gh

    hypridle
    hyprlock
    hyprpaper
    hyprshot
    hyprtoolkit
  ];
}
