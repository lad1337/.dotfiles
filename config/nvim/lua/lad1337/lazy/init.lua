return {
  { 'nvim-lua/plenary.nvim', name = 'plenary' },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { 'mrjones2014/nvim-ts-rainbow' },
  {
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
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
  {
    url = 'https://git.sr.ht/~lad1337/lsp_lines.nvim',
    -- dir = '~/workspace/lsp_lines.nvim',
    branch = 'overlay',
    config = function()
      require('lsp_lines').setup()
    end,
  },
  {
    'lad1337/marks.nvim',
    -- dir = '~/workspace/marks.nvim',
    branch = 'everything',
    event = 'VeryLazy',
    config = function()
      local opts = {
        preview_mappings = { { 'n', 'q', ':bd<CR>' } },
        preview_size = { 0.8, 0.7 },
        sign_priority = 0,
      }
      require('marks').setup(opts)
      require('telescope').load_extension 'marks_nvim'
    end,
  },
  {
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
  {
    'BrunoKrugel/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        user_default_options = {
          rgb_fn = true,
          mode = 'virtualtext',
        },
      }
    end,
  },
  { 'f3fora/cmp-spell', enabled = false },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup()
    end,
    enabled = true,
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      show_auto_restore_notif = true,
      -- log_level = 'debug',
    },
  },
}
