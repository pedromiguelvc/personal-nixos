{ pkgs, lib, ... }:

let
  tools = [
    {
      key = "g";
      title = "Lazygit";
      cmd = "lazygit";
      w = 90;
      h = 90;
      direnv = true;
    }
    {
      key = "r";
      title = "Tuicr";
      cmd = "tuicr";
      w = 95;
      h = 95;
      direnv = true;
    }
    {
      key = "e";
      title = "Yazi";
      cmd = "yazi";
      w = 80;
      h = 80;
      direnv = true;
    }
    {
      key = "b";
      title = "Btop";
      cmd = "btop";
      w = 80;
      h = 80;
      direnv = false;
    }
  ];
  mkTool =
    t:
    let
      x = toString ((100 - t.w) / 2);
      y = toString ((100 - t.h) / 2);
      full = (lib.optionalString t.direnv "direnv exec . ") + t.cmd;
      match = "#{&&:#{pane_floating_flag},#{m:*${t.cmd}*,#{pane_start_command}}}";
    in
    ''
      bind-key ${t.key} if -F '#{P:#{?${match},1,}}' \
        "run-shell 'tmux select-pane -t #{P:#{?${match},#{pane_id},}}'" \
        'new-pane -A -x ${toString t.w}% -y ${toString t.h}% -X ${x}% -Y ${y}% -T "${t.title}" -c "#{pane_current_path}" "${full}"'
    '';

  toolBindings = lib.concatMapStrings mkTool tools;

in

{
  programs.tmux = {
    enable = true;

    shortcut = "s";
    keyMode = "vi";
    terminal = "tmux-256color";
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = false;
    escapeTime = 0;
    aggressiveResize = true;
    clock24 = true;
    mouse = true;
    focusEvents = true;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
      vim-tmux-navigator
      mode-indicator
      tmux-fzf
    ];
    extraConfig =
      builtins.readFile ./config/tmux/tmux.conf
      + toolBindings
      + ''
        run-shell ${pkgs.tmuxPlugins.mode-indicator.rtp}
        run-shell ${pkgs.tmuxPlugins.continuum.rtp}
        run-shell ${pkgs.tmuxPlugins.tmux-fzf.rtp}
      '';
  };
}
