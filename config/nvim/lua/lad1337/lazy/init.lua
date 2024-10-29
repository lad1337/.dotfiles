return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'nvim-lua/plenary.nvim', name = 'plenary' },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { 'mrjones2014/nvim-ts-rainbow' },
  {
    'zoriya/virtcolumn.nvim',
    config = function()
      vim.cmd 'set cc=100'
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  {
    -- url = 'https://git.sr.ht/~lad1337/lsp_lines.nvim',
    branch = 'overlay',
    dir = '~/workspace/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
    end,
  },
  {
    -- "lad1337/marks.nvim",
    dir = '~/workspace/marks.nvim',
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
  'f3fora/cmp-spell',
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup()
    end,
  },
}
