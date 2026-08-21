{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
    cliphist
    libnotify

    nerd-fonts._0xproto

    lua-language-server
    nil
    nixfmt
    luarocks
    stylua
    tree-sitter
    gh

    ashell
    brave
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    hyprtoolkit
  ];
}
