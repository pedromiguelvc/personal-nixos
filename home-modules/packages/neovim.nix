{
  lib,
  pkgs,
  config,
  ...
}:

{
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
  };
  home.packages = lib.optionals config.programs.neovim.enable (
    with pkgs;
    [
      inotify-tools
      lua-language-server
      nixd
      nixfmt
      luarocks
      stylua
      tree-sitter
    ]
  );
}
