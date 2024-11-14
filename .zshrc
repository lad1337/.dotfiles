# vim: ft=sh
# THE PATH
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export DOT="$HOME/.dotfiles"
export GOPATH="$HOME/.gopath"
export GOBIN="$GOPATH/bin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$DOT/bin:$HOME/.local/bin:$HOME/.poetry/bin:$GOBIN:$PATH"
export PATH=$PATH:/opt/homebrew/bin
# not seeting theme as the plugin is installed outside of the ZSH/plugin dir
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh/custom"
DISABLE_UPDATE_PROMPT=true
export ITERM2_SQUELCH_MARK=1
export EDITOR=nvim

# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(git zsh-syntax-highlighting vi-mode colored-man-pages zsh-fzf-history-search)

export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:"
# https://github.com/bhilburn/powerlevel9k
: '
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
POWERLEVEL9K_VCS_SHORTEN_LENGTH=16
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=11
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-remotebranch git-tagname)
# <space> forces the seprator to appear
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh nix_shell dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs virtualenv kubecontext)
'
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
  autoload -Uz compinit
  compinit
fi

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
alias ze="$EDITOR ~/.zshrc"

# langauage stuff
# python virtual env stuff
# we speak english
#export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
# bat color theme
# https://github.com/sharkdp/bat#highlighting-theme
export BAT_THEME="OneHalfDark"

# load all other 'extensions'
# source "$DOT/colorman.zsh"
# git-flower, config:
# url is without the key/id

commands[kubectl]="something"

# LOAD all other functions
# source $DOT/functions/*.sh
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
export VIRTUAL_ENV_DISABLE_PROMPT=""
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


source $ZSH/oh-my-zsh.sh
