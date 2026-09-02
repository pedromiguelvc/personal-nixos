{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    shortcut = "s";
    keyMode = "vi";
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = false;
    escapeTime = 0;
    aggressiveResize = true;
    clock24 = true;
    newSession = true;
    mouse = true;
    focusEvents = true;

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
