return {
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {}
    end,
    keys = {
      { '<leader>(', '<Plug>(nvim-surround-normal)iw(', 'Surround word with )' },
      { '<leader>)', '<Plug>(nvim-surround-normal)iw)', 'Surround work with (' },
      { '<leader>]', '<Plug>(nvim-surround-normal)iw]', 'Surround word with ]' },
      { '<leader>[', '<Plug>(nvim-surround-normal)iw[', 'Surround word with [' },
      { "<leader>'", "<Plug>(nvim-surround-normal)iw'", "Surround word with '" },
      { '<leader>"', '<Plug>(nvim-surround-normal)iw"', 'Surround word with "' },
    },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = { enabled = true },
      bigfile = { enabled = true },
      ---@class snacks.indent.Config
      ---@field enabled? boolean
      indent = {
        enabled = true,
        indent = {
          only_current = true,
          only_scope = true,
        },
        animate = { enabled = false },
        scope = {
          enabled = false, -- disabled due to treesitter bug with nvim 0.12
          underline = false,
          hl = 'Bold',
        },
      },
      input = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = false }, -- disabled due to treesitter bug with nvim 0.12
      statuscolumn = {
        enabled = true,
        left = { 'sign' },
      },
      words = { enabled = true },
    },
    keys = {
      { '<leader>lg', '<cmd>lua Snacks.lazygit()<cr>', 'Open Lazygit' },
    },
  },
  { 'b0o/schemastore.nvim', lazy = true },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
  { 'f3fora/cmp-spell', enabled = false },
  { -- render-markdown: you need this for all the docs, this custom branch removes some headline stuff
    'lad1337/render-markdown.nvim',
    -- dir = '~/workspace/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        border = true,
        above = '',
        below = '󱋰',
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
      },
    },
  },
  { -- auto-session: remembers where you left off for the CWD
    -- use :SessionSearch and C-d to delete from another instance
    'rmagatti/auto-session',
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      lazy_support = true,
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      show_auto_restore_notif = true,
      -- log_level = 'debug',
    },
  },
  { -- folding: remaps h/l to open/close folds
    'chrisgrieser/nvim-origami',
    dependencies = { 'kevinhwang91/nvim-ufo' },
    lazy = true,
    event = 'VeryLazy',
    opts = {
      foldKeymaps = {
        setup = true,
        hOnlyOpensOnFirstColumn = true,
      },
    },
  },
}
