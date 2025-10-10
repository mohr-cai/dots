# Login shell configuration keeps environment consistent across interactive shells.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

[[ -f "$XDG_CONFIG_HOME/shell/vars" ]] && source "$XDG_CONFIG_HOME/shell/vars"
