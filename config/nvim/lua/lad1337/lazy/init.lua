return {
  -- { -- lsp_lines: dignostics as virtual text on current line 0.11 still does not do it as virtual text which this branch does
  --   url = 'https://git.sr.ht/~lad1337/lsp_lines.nvim',
  --   -- dir = '~/workspace/lsp_lines.nvim',
  --   branch = 'overlay',
  --   config = function()
  --     require('lsp_lines').setup()
  --   end,
  -- },
  {
    'j-hui/fidget.nvim',
    opts = {
      -- options
      progress = {
        notification_group = function(msg)
          -- N.B. you may also want to configure this group key ("lsp_progress")
          -- using progress.display.overrides or notification.configs
          return 'lsp_progress'
        end,
      },
      notification = {
        override_vim_notify = true,
      },
    },
  },
  -- { -- nvim-notify: fance notifications UI
  --   'rcarriga/nvim-notify',
  --   config = function()
  --     vim.notify = require 'notify'
  --   end,
  -- },
  -- {
  --   'mrded/nvim-lsp-notify',
  --   dependencies = { 'rcarriga/nvim-notify' },
  --   config = function()
  --     require('lsp-notify').setup()
  --   end,
  -- },
  {
    'https://github.com/uga-rosa/ccc.nvim',
    opts = {},
  },
}
