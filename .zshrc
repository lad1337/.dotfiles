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
# https://github.com/sharkdp/bat#highlighting-theme
export BAT_THEME="OneHalfDark"

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
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#900048,bg:-1,spinner:#ff0e82,hl:#00ffb7 \
                        --color=fg:#cdd6f4,header:#ff0e82,info:#cba6f7,pointer:#00ffb7 \
                        --color=marker:#900048,fg+:#00ffb7,prompt:#cba6f7,hl+:#00ffb7"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.cargo/env ] && source ~/.cargo/env
source $ZSH/oh-my-zsh.sh
