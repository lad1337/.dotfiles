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

| Name | Hex | Usage |
|------|-----|-------|
| Foreground | `#cdd6f4` | Main text |
| Magenta | `#ff0e82` | Accents, error backgrounds |
| Magenta2 | `#900048` | Secondary magenta |
| Cyan | `#00ffb7` | Highlights, pointers |
| Purple | `#cba6f7` | Info, prompts |
| Neon Yellow | `#EDFF00` | Current line number, git modified, word highlights |

### Applied To

- **Neovim (Tokyo Night)**: `config/nvim/lua/lad1337/init.lua`
  - `on_colors`: fg, magenta, magenta2, cyan, purple
  - `on_highlights`: CursorLineNr, LspReference*, NeoTreeGitModified

- **iTerm2**: `config/iterm/tokyonight_night.itermcolors`
  - Ansi 3/11 (yellow): `#EDFF00`
  - Ansi 5/13 (magenta): `#ff0e82`
  - Ansi 6/14 (cyan): `#00ffb7`
  - Foreground: `#cdd6f4`

- **Powerlevel10k**: `.p10k.zsh`
  - Error backgrounds: ANSI 5 (magenta)
  - Kubecontext: foreground ANSI 3 (neon yellow), background ANSI 5 (magenta)

- **FZF**: Configured via `FZF_DEFAULT_OPTS` in shell

- **bat**: `config/bat/themes/tokyonight-custom.tmTheme`
  - Keywords/tags: `#ff0e82` (magenta)
  - Strings/operators: `#00ffb7` (cyan)
  - Functions/attributes: `#cba6f7` (purple)
  - Classes/types: `#EDFF00` (neon yellow)
  - Selection: `#900048` (magenta2)

- **lazygit**: `config/lazygit/config.yml`
  - Active border: `#EDFF00` (neon yellow)
  - Selected line bg: `#900048` (magenta2)
  - Unstaged changes: `#ff0e82` (magenta)
  - Options text: `#cba6f7` (purple)

- **git-delta**: `.gitconfig`
  - Plus lines: `#00ffb7` (cyan)
  - Minus lines: `#ff0e82` (magenta)
  - Commit decoration: `#EDFF00` (neon yellow)
  - File style: `#cba6f7` (purple)

- **k9s**: `config/k9s/skins/tokyonight-custom.yaml`
  - Logo/highlights: `#EDFF00` (neon yellow)
  - Cursor bg: `#900048` (magenta2)
  - Status new/add: `#00ffb7` (cyan)
  - Errors/keys: `#ff0e82` (magenta)
  - Info/crumbs: `#cba6f7` (purple)

- **zsh-syntax-highlighting**: `.zshrc`
  - Commands/functions: `#cba6f7` (purple)
  - Strings: `#00ffb7` (cyan)
  - Redirections/reserved: `#ff0e82` (magenta)
  - Paths: `#EDFF00` (neon yellow)
