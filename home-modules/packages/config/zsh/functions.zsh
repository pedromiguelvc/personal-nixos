zstyle ':completion:*' menu select
setopt auto_menu

_nixos-rebuild() {
  local subcmd="$1"; shift
  git -C ~/nixos add -A
  sudo nixos-rebuild "$subcmd" --flake ~/nixos#"$(hostname)" "$@"
}

ns()  { _nixos-rebuild switch "$@" }
nst() { _nixos-rebuild test "$@" }
nsb() { _nixos-rebuild build "$@" }

function _launch_claude_code() {
  zle -I
  claude
  zle reset-prompt
}
function _clear_prompt() {
  zle -I
  clear
  zle reset-prompt
}
function _exit_shell() {
  exit
}

zle -N _launch_claude_code
zle -N _clear_prompt
zle -N _exit_shell

bindkey '^Xc' _launch_claude_code
bindkey '^Xx' _clear_prompt
bindkey '^Xe' _exit_shell
