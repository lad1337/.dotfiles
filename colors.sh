# Color palette - source of truth for all tools
# Used by: .zshrc, install.conf.yaml (git config)

export COLOR_FG='#cdd6f4'
export COLOR_MAGENTA='#ff0e82'
export COLOR_MAGENTA2='#900048'
export COLOR_CYAN='#00ffb7'
export COLOR_PURPLE='#7c3aed'
export COLOR_YELLOW='#EDFF00'
export COLOR_GREY='#3d3d3d'

# Semantic aliases
export COLOR_DIRECTORY=$COLOR_CYAN
export COLOR_EXECUTABLE=$COLOR_MAGENTA
export COLOR_SYMLINK=$COLOR_PURPLE
export COLOR_ARCHIVE=$COLOR_YELLOW

# Helper: convert #RRGGBB to 38;2;R;G;B for LS_COLORS
hex_to_ansi() {
  local hex="${1#\#}"
  printf "38;2;%d;%d;%d" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
}
