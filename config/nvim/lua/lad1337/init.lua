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

local icons = require 'lad1337.icons'
vim.diagnostic.config {
  virtual_text = false,
  float = {
    border = 'rounded',
    focusable = false,
  },
  -- virtual_lines = {
  --   only_current_line = false,
  --   overlay = false,
  --   strip = true,
  -- },
  virtual_lines = false,
  signs = {
    -- no diagnostic signs!
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
-- https://www.reddit.com/r/neovim/comments/1kq8jxb/just_wanted_to_share_this_little_config_snippet_i/?share_id=mDMhOdxBn8s3djBMO_NMY&utm_content=1&utm_medium=ios_app&utm_name=iossmf&utm_source=share&utm_term=22
-- Show errors and warnings in a floating window
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = 'if_many' })
  end,
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
  max_width = 100, -- this is an absolute value -.-
})

-- automatically resize windows equally when terminal resizes
vim.api.nvim_create_autocmd('VimResized', { command = 'wincmd =' })

require 'lad1337.keys'
require 'lad1337.py_async_helpers'
require 'lad1337.structurizr'
