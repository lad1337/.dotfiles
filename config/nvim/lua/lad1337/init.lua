-- setup
vim.cmd.colorscheme 'lunar'
local icons = require 'lad1337.icons'
require 'lad1337.set'
require 'lad1337.keys'

require 'lad1337.init_lazy'
require('lazy').setup {
  spec = 'lad1337.lazy',
  change_detection = { notify = false },
}
require 'lad1337.godot'

-- config
require('lualine').setup {}
local signs = {
  Error = icons.diagnostics.Error,
  Warn = icons.diagnostics.Warning,
  Hint = icons.diagnostics.Hint,
  Info = icons.diagnostics.Information,
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = {
    only_current_line = true,
    overlay = true,
    strip = true,
  },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
  max_width = 100, -- this is an absolute value -.-
})

-- automatically resize windows equally when terminal resizes
vim.api.nvim_create_autocmd('VimResized', { command = 'wincmd =' })
