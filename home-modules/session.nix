{
  home.sessionVariables = {
    EDITOR = "nvim";
    KEYTIMEOUT = "1";
    _ZO_DOCTOR = "0";

    ZSH_TMUX_AUTOSTART = "true";
    ZSH_TMUX_AUTOQUIT = "false";

    FZF_DEFAULT_OPTS = "--bind=tab:down,shift-tab:up --layout=reverse";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];
}
