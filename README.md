# .dotfiles

using [dotbot](https://github.com/anishathalye/dotbot)

## install
```sh
    git clone git@github.com:lad1337/.dotfiles.git
    cd .dotfiles
    ./install
```

This is bud hammer

## Color Palette

Custom color overwrites applied across tools for a consistent theme based on Tokyo Night with FZF-inspired accents and Cyberpunk Edgerunners vibes.

### Colors

| Name | Hex | Semantic Usage |
|------|-----|----------------|
| Foreground | `#cdd6f4` | Main text |
| Magenta | `#ff0e82` | Keywords, executables, errors |
| Magenta2 | `#900048` | Selection background |
| Cyan | `#00ffb7` | Commands, directories |
| Purple | `#cba6f7` | Strings, symlinks |
| Neon Yellow | `#EDFF00` | Current line, git modified, archives |

### Source of Truth

`.zshrc` exports `COLOR_*` variables that are used by:

**Dynamic (uses env vars):**
- **Neovim**: `colors.lua` reads `vim.env.COLOR_*`
- **FZF**: `FZF_DEFAULT_OPTS` uses `$COLOR_*`
- **LS_COLORS**: uses `hex_to_ansi()` helper with `$COLOR_*`
- **zsh-syntax-highlighting**: uses `$COLOR_*`
- **git status/delta**: set via `git config` commands in `.zshrc`

**Static (requires manual sync):**
- **iTerm2**: `config/iterm/tokyonight_night.itermcolors`
- **Powerlevel10k**: `.p10k.zsh` (uses ANSI color numbers)
- **bat**: `config/bat/themes/tokyonight-custom.tmTheme`
- **lazygit**: `config/lazygit/config.yml`
- **k9s**: `config/k9s/skins/tokyonight-custom.yaml`
