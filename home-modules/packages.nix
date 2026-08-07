{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Basics
    bat
    btop
    curl
    eza
    fd
    fzf
    jq
    neovim
    ripgrep
    trash-cli
    wl-clipboard
    gcc
    gnumake
    yazi
    procps
    wlogout
    fastfetch

    # Fonts
    nerd-fonts._0xproto

    lua-language-server
    nil
    nixfmt
    luarocks
    stylua
    tree-sitter

    gh
    # Desktop
    ashell
    brave
    hypridle
    hyprlauncher
    hyprlock
    hyprpaper
    hyprshot
    hyprtoolkit
    rofi
    swaynotificationcenter
  ];
}
