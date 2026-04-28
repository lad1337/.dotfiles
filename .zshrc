# vim: ft=sh
# THE PATH
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export DOT="$HOME/.dotfiles"
export GOPATH="$HOME/.gopath"
export GOBIN="$GOPATH/bin"
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/opt/python@3.13/libexec/bin:$PATH
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$HOME/bin:$DOT/bin:$HOME/.local/bin:$HOME/.poetry/bin:$GOBIN:$PATH"
# not seeting theme as the plugin is installed outside of the ZSH/plugin dir
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh/custom"
DISABLE_UPDATE_PROMPT=true
export ITERM2_SQUELCH_MARK=1
export EDITOR=nvim

# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

plugins=(git zsh-syntax-highlighting vi-mode colored-man-pages zsh-fzf-history-search kubectl-autocomplete)

# ANSI color number mappings (for p10k which is sourced early)
# These map to iTerm color slots configured in tokyonight_night.itermcolors
export ANSI_YELLOW=3
export ANSI_MAGENTA=5
export ANSI_CYAN=6

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# info with: brew info zsh-completions
if type brew &>/dev/null; then
  fpath=($fpath /opt/homebrew/share/zsh/site-functions)
  autoload -Uz compinit
  compinit
fi

# zsh-manage
alias zr="source ~/.zshrc"
alias ze="$EDITOR ~/.zshrc"

export LANG=en_GB.UTF-8
# Custom color palette (source of truth, used by nvim via vim.env)
export COLOR_FG='#cdd6f4'
export COLOR_MAGENTA='#ff0e82'
export COLOR_MAGENTA2='#900048'
export COLOR_CYAN='#00ffb7'
export COLOR_PURPLE='#cba6f7'
export COLOR_YELLOW='#EDFF00'
# Semantic
export COLOR_DIRECTORY=$COLOR_CYAN
export COLOR_EXECUTABLE=$COLOR_MAGENTA
export COLOR_SYMLINK=$COLOR_PURPLE
export COLOR_ARCHIVE=$COLOR_YELLOW

# Helper: convert #RRGGBB to 38;2;R;G;B for LS_COLORS
hex_to_ansi() {
  local hex="${1#\#}"
  printf "38;2;%d;%d;%d" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
}

# Git colors (git config doesn't support env vars, so set via commands)
git config --global color.status.added "$COLOR_CYAN"
git config --global color.status.changed "$COLOR_YELLOW"
git config --global color.status.untracked "$COLOR_MAGENTA"
# git-delta colors
git config --global delta.minus-style "syntax \"#3a1830\""
git config --global delta.minus-emph-style "black $COLOR_MAGENTA2"
git config --global delta.plus-style "syntax \"#1a3a2a\""
git config --global delta.plus-emph-style "black $COLOR_CYAN"
git config --global delta.line-numbers-minus-style "$COLOR_MAGENTA"
git config --global delta.line-numbers-plus-style "$COLOR_CYAN"
git config --global delta.line-numbers-zero-style "#565f89"
git config --global delta.commit-decoration-style "bold $COLOR_YELLOW box ul"
git config --global delta.file-style "bold $COLOR_PURPLE ul"
git config --global delta.hunk-header-decoration-style "$COLOR_MAGENTA box"
git config --global delta.hunk-header-style "file line-number $COLOR_PURPLE"

# LS_COLORS (uses 24-bit true color)
export LS_COLORS="di=$(hex_to_ansi $COLOR_DIRECTORY):ex=$(hex_to_ansi $COLOR_EXECUTABLE):ln=$(hex_to_ansi $COLOR_SYMLINK):*.tar=$(hex_to_ansi $COLOR_ARCHIVE):*.gz=$(hex_to_ansi $COLOR_ARCHIVE):*.zip=$(hex_to_ansi $COLOR_ARCHIVE):*.7z=$(hex_to_ansi $COLOR_ARCHIVE):*.rar=$(hex_to_ansi $COLOR_ARCHIVE)"

# zsh-syntax-highlighting custom colors (uses palette above)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=$COLOR_CYAN"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$COLOR_CYAN"
ZSH_HIGHLIGHT_STYLES[function]="fg=$COLOR_CYAN"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$COLOR_CYAN"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$COLOR_PURPLE"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$COLOR_PURPLE"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$COLOR_PURPLE"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=$COLOR_MAGENTA"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$COLOR_MAGENTA"
ZSH_HIGHLIGHT_STYLES[path]="fg=$COLOR_YELLOW,underline"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$COLOR_MAGENTA"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$COLOR_MAGENTA,bold"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$COLOR_MAGENTA"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=$COLOR_CYAN"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$COLOR_PURPLE,italic"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$COLOR_CYAN"

# what is this???
commands[kubectl]="something"

# LOAD all other functions
# source $DOT/functions/*.sh
compdef _ssh_hosts tunnel-anything
# custom kybingins and there functions
source "$DOT/keybindins.zsh"
source "$DOT/alias.sh"
source "$DOT/functions/stuff.sh"
source "$DOT/functions/k8s.sh"
source $(which uv-virtualenvwrapper.sh)

# load fuzzy finder
# currently installed by vim plugin manager
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --reverse --inline-info --preview "LS_COLORS=\"ow=01;90:di=01;90\" tree -C --matchdirs --prune -P $(basename {})"'
export FZF_DEFAULT_COMMAND='fd --type f'
# https://www.wildberries.style/fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:$COLOR_MAGENTA2,bg:-1,spinner:$COLOR_MAGENTA,hl:$COLOR_CYAN \
                        --color=fg:$COLOR_FG,header:$COLOR_MAGENTA,info:$COLOR_PURPLE,pointer:$COLOR_CYAN \
                        --color=marker:$COLOR_MAGENTA2,fg+:$COLOR_CYAN,prompt:$COLOR_PURPLE,hl+:$COLOR_CYAN"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.cargo/env ] && source ~/.cargo/env
source $ZSH/oh-my-zsh.sh
