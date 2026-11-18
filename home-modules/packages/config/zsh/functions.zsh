zstyle ':completion:*' menu select
setopt auto_menu
bindkey -v

notify_done() {
    local status_code=$?
    local cmd="${history[$HISTCMD]%% NT*}"
    if [[ $status_code -eq 0 ]]; then
        notify-send -i dialog-ok "Done: $cmd" "Finished successfully."
    else
        notify-send -u critical -i dialog-error "Failed: $cmd" "Exit status: $status_code"
    fi
    return $status_code
}

_nixos-rebuild() {
  local subcmd="$1"; shift
  git -C ~/nixos add -A
  nh os "$subcmd" ~/nixos "$@"
}

ns()  { _nixos-rebuild switch "$@" }
nst() { _nixos-rebuild test "$@" }
nsb() { _nixos-rebuild build "$@" }
