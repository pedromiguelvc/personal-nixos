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

    brave
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    hyprtoolkit
  ];
}
