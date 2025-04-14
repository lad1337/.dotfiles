return {
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = {
    'nvim-lua/plenary.nvim',
  }, opts = { signs = false } },
  -- { 'mrjones2014/nvim-ts-rainbow', opts = {} },
  { -- virtcolumn: line length marker
    'zoriya/virtcolumn.nvim',
    config = function()
      vim.cmd 'set cc=100'
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
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
  { -- snacks: statuscolumn, indent and better input, no idea what words does but it sounded cool
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      -- dashboard = { enabled = true },
      ---@class snacks.indent.Config
      ---@field enabled? boolean
      indent = {
        enabled = true,
        indent = {
          only_current = true,
          only_scope = true,
        },
        animate = {
          enabled = false,
        },
        scope = {
          enabled = true,
          underline = false,
          -- char = '⎸',
          hl = 'Bold',
        },
      },
      input = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      -- scroll = { enabled = true },
      statuscolumn = {
        enabled = true,
        left = {
          -- "mark",
          'sign',
        },
      },
      words = { enabled = true },
    },
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  { -- lsp_lines: dignostics as virtual text on current line 0.11 still does not do it as virtual text which this branch does
    url = 'https://git.sr.ht/~lad1337/lsp_lines.nvim',
    -- dir = '~/workspace/lsp_lines.nvim',
    branch = 'overlay',
    config = function()
      require('lsp_lines').setup()
    end,
  },
  { -- nvim-notify: fance notifications UI
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
    end,
  },
  {
    'mrded/nvim-lsp-notify',
    dependencies = { 'rcarriga/nvim-notify' },
    config = function()
      require('lsp-notify').setup()
    end,
  },
  { 'f3fora/cmp-spell', enabled = false },
  { -- render-markdown: you need this for all the docs, this costum branch does remove some headline stuff, i forgot
    'lad1337/render-markdown.nvim',
    -- dir = '~/workspace/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        border = true,
        above = '',
        below = '󱋰',
        backgrounds = {},
        border_backgrounds = {
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
  { -- auto-session: remembers where you left of for the CWD, when working on vim config might want to delete sessions_dir
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
}
