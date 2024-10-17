# vim: ft=sh
# THE PATH
export GOPATH="$HOME/.gopath"
export GOBIN="$GOPATH/bin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$DOT/bin:$HOME/.local/bin:$HOME/.poetry/bin:$GOBIN:$PATH"
export PATH=$PATH:/opt/homebrew/bin

export ZSH="$HOME/.oh-my-zsh"
eval "$(starship init zsh)"

DISABLE_UPDATE_PROMPT=true
export DOT="$HOME/.dotfiles"
# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit snippet OMZP::git
zinit snippet OMZL::directories.zsh

# info with: brew info zsh-completions
if type brew &>/dev/null; then
  autoload -Uz compinit
  compinit
fi
# if the init script doesn't exist

export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# overwrite vcs state colors as theme does not have a nice yellow
# https://github.com/Powerlevel9k/powerlevel9k/blob/3057e8fc07374e9c580790a023cb85998ca91fc8/powerlevel9k.zsh-theme#L1536
typeset -gAH vcs_states
  vcs_states=(
    'clean'         'green'
    'modified'      'cyan'
    'untracked'     'green'
  )


# zsh-manage
alias zr="source ~/.zshrc"
alias ze="lvim ~/.zshrc"

# langauage stuff
# python virtual env stuff
export VIRTUAL_ENV_DISABLE_PROMPT=""
# we speak english
#export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
# bat color theme
# https://github.com/sharkdp/bat#highlighting-theme
export BAT_THEME="OneHalfDark"
# i use nvim... now lvim
export EDITOR=lvim

# load all other 'extensions'
source "$DOT/colorman.zsh"
# git-flower, config:
# url is without the key/id

commands[kubectl]="something"

# LOAD all other functions
source $DOT/functions/*.sh
compdef _ssh_hosts tunnel-anything
# custom kybingins and there functions
source "$DOT/keybindins.zsh"
source "$DOT/alias.sh"

# load fuzzy finder
# currently installed by vim plugin manager
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --reverse --inline-info --preview "LS_COLORS=\"ow=01;90:di=01;90\" tree -C --matchdirs --prune -P $(basename {})"'
export FZF_DEFAULT_COMMAND='fd --type f'

# enable pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

