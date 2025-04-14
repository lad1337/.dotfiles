-- setup
vim.cmd.colorscheme 'lunar'
require 'lad1337.set'
require 'lad1337.functions'

-- plugins lazy
require 'lad1337.init_lazy'
require('lazy').setup {
  spec = 'lad1337.lazy',
  change_detection = { notify = false },
}

-- config
require('lualine').setup {}

local icons = require 'lad1337.icons'
vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = {
    only_current_line = true,
    overlay = true,
    strip = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '', --icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = '', --icons.diagnostics.Warning,
      [vim.diagnostic.severity.HINT] = '', --icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = '', --icons.diagnostics.Information,
    },

    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarning',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInformation',
    },
  },
}

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
  max_width = 100, -- this is an absolute value -.-
})

-- automatically resize windows equally when terminal resizes
vim.api.nvim_create_autocmd('VimResized', { command = 'wincmd =' })
require 'lad1337.keys'
