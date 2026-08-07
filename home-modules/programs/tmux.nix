{ pkgs, ... }:

let
  tmux-mode-indicator = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-mode-indicator";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "MunifTanjim";
      repo = "tmux-mode-indicator";
      rev = "master";
      hash = "sha256-SAzsn4LoG8Ju5t13/U3/ctlJQPyPgv2FjpPkWSeKbP0=";
    };
  };
in
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
      vim-tmux-navigator
      tmux-mode-indicator
      tmux-fzf
    ];

    extraConfig = builtins.readFile ./config/tmux/tmux.conf;
  };
}
