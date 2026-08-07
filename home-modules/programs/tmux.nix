{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
      vim-tmux-navigator
      mode-indicator
      tmux-fzf
    ];
    extraConfig = builtins.readFile ./config/tmux/tmux.conf + ''
      run-shell ${pkgs.tmuxPlugins.mode-indicator.rtp}
      run-shell ${pkgs.tmuxPlugins.continuum.rtp}
    '';
  };
}
