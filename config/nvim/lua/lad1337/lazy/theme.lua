return {
  -- { 'ianklapouch/wildberries.nvim', name = 'wildberries', priority = 1000 },
  -- { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  -- { 'maxmx03/fluoromachine.nvim', lazy = false, priority = 1000 },
  -- { 'Everblush/nvim', name = 'everblush', priority = 1000 },
  -- { 'diegoulloao/neofusion.nvim', priority = 1000, config = true },
  -- { 'ingenarel/cyberpunk-neon.nvim', priority = 1000 },
  -- { 'hyperb1iss/silkcircuit', lazy = false, priority = 1000 },
  -- { 'rockerBOO/boo-colorscheme-nvim', lazy = false, priority = 1000 },
  -- { 'oxidescheme/nvim', name = 'oxid', lazy = false, priority = 1000 },
  -- { 'LucaasHenrique/irwtsayh.nvim', lazy = false, priority = 1000 },
  -- { 'vim-scripts/Relaxed-Green', lazy = false, priority = 1000 },
  -- { 'vim-scripts/DarkZen-Color-Scheme', lazy = false, priority = 1000 },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local c = require 'lad1337.colors'
      require('tokyonight').setup {
        style = 'night',
        styles = { functions = {} },
        on_colors = function(colors)
          colors.hint = colors.orange
          colors.error = c.error
          colors.fg = c.fg
          colors.magenta = c.magenta
          colors.magenta2 = c.magenta2
          colors.cyan = c.cyan
          colors.purple = c.purple
        end,
        on_highlights = function(hl, colors)
          -- Edgerunners jacket neon yellow
          hl.CursorLineNr = { fg = c.yellow, bold = true }
          -- Word references on cursor hold
          hl.LspReferenceText = { bg = c.yellow, fg = colors.bg }
          hl.LspReferenceRead = { bg = c.yellow, fg = colors.bg }
          hl.LspReferenceWrite = { bg = c.yellow, fg = colors.bg }
          -- Floating window borders
          hl.FloatBorder = { fg = c.yellow, bold = true }
          -- Neo-tree
          hl.NeoTreeGitModified = { fg = c.git_modified }
          hl.NeoTreeDirectoryIcon = { fg = c.directory }
          hl.NeoTreeDirectoryName = { fg = c.directory }
          hl.NeoTreeRootName = { fg = c.directory, bold = true }
          hl.NeoTreeFileExecutable = { fg = c.executable }
        end,
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}
