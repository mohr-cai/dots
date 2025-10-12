# Login shell configuration keeps environment consistent across interactive shells.
if [[ -z "${XDG_CONFIG_HOME:-}" && -d "$HOME/dots/.config" ]]; then
  export XDG_CONFIG_HOME="$HOME/dots/.config"
else
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
fi
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

[[ -f "$XDG_CONFIG_HOME/shell/vars" ]] && source "$XDG_CONFIG_HOME/shell/vars"

# $HOME/dots/.config/zsh/.zprofile
# Homebrew path
eval "$(/opt/homebrew/bin/brew shellenv)"