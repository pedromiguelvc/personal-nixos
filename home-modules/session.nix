{
  home.sessionVariables = {
    EDITOR = "nvim";
    KEYTIMEOUT = "1";
    _ZO_DOCTOR = "0";

    FZF_DEFAULT_OPTS =
      "--bind=tab:down,shift-tab:up --layout=reverse";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];
}
