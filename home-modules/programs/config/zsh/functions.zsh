autoload -U add-zsh-hook

zstyle ':completion:*' menu select
setopt auto_menu menu_complete
_auto_venv() {
  if [[ -d ".venv" && -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}

add-zsh-hook chpwd _auto_venv

function _launch_claude_code() {
  claude
  zle reset-prompt
}
function _clear_prompt() {
  clear
  zle reset-prompt
}
function _exit_shell() {
  zle -I
  exit
}

zle -N _launch_claude_code
zle -N _clear_prompt
zle -N _exit_shell

bindkey '^Xc' _launch_claude_code
bindkey '^Xx' _clear_prompt
bindkey '^Xe' _exit_shell
