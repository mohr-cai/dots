# Base directories (fallback to sensible defaults)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
mkdir -p "$XDG_CACHE_HOME"/{oh-my-zsh,zsh}

# Shared shell config
[[ -f "$XDG_CONFIG_HOME/shell/alias" ]] && source "$XDG_CONFIG_HOME/shell/alias"
[[ -f "$XDG_CONFIG_HOME/shell/vars" ]] && source "$XDG_CONFIG_HOME/shell/vars"

# Completion configuration
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes false
[[ -n "${LS_COLORS:-}" ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" ma=0\;33

zmodload zsh/complist
autoload -Uz compinit colors

# Oh My Zsh
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$XDG_CACHE_HOME/oh-my-zsh}"
export ZSH_COMPDUMP="${ZSH_COMPDUMP:-$XDG_CACHE_HOME/zsh/zcompdump-$HOST}"
export ZSH_DISABLE_COMPFIX=true
skip_global_compinit=1

compinit -d "$ZSH_COMPDUMP"
colors

# Shell options
setopt append_history inc_append_history share_history
setopt auto_menu menu_complete autocd auto_param_slash
setopt extended_glob globdots interactive_comments
setopt no_case_glob no_case_match hist_ignore_space hist_ignore_dups
setopt prompt_subst
unsetopt prompt_sp
stty stop undef

# History configuration
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"

# fzf integration
if command -v fzf >/dev/null 2>&1; then
  if [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
  else
    source <(fzf --zsh)
  fi

  (( $+functions[fzf-history-widget] )) && bindkey '^R' fzf-history-widget
fi

# Key bindings
bindkey -e
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^H' backward-kill-word
bindkey '^J' history-search-forward
bindkey '^K' history-search-backward
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# Load Oh My Zsh (plugins, theme scaffolding)
ZSH_THEME="awesomepanda"
plugins=(git zsh-autosuggestions)
source "$ZSH/oh-my-zsh.sh"
unset skip_global_compinit

# Prompt
parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

PROMPT=$'\n'
PROMPT+='%F{8}[%D{%H:%M}]%f '
PROMPT+='%F{cyan}%n%f '
PROMPT+='%F{yellow}%~%f '
PROMPT+='$(git_branch=$(parse_git_branch); [[ -n $git_branch ]] && echo "%F{magenta} ${git_branch}%f") '
PROMPT+='%(?.%F{green}❯.%F{red}❯)%f '

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
_conda_home="${CONDA_DIR:-$HOME/miniconda3}"
__conda_setup="$("$_conda_home/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$_conda_home/etc/profile.d/conda.sh" ]; then
        . "$_conda_home/etc/profile.d/conda.sh"
    else
        export PATH="$_conda_home/bin:$PATH"
    fi
fi
unset __conda_setup _conda_home
# <<< conda initialize <<<

# Load shared environment variables.
if [[ -r "$HOME/dots/.config/shell/vars" ]]; then
  source "$HOME/dots/.config/shell/vars"
fi

# Load shell aliases.
if [[ -r "$HOME/dots/.config/shell/alias" ]]; then
  source "$HOME/dots/.config/shell/alias"
fi
