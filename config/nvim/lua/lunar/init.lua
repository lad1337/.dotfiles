local M = {}
local theme = require 'lunar.theme'

M.setup = function()
  vim.cmd 'hi clear'

  vim.o.background = 'dark'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'lunar'

  theme.set_highlights()
  local utils = require 'lunar.util'
  local modules = {
    'Notify',
    'IndentBlankline',
    'Telescope',
    'Cmp',
  }
  for _, name in ipairs(modules) do
    utils.initialise(require('lunar.' .. name))
  end
end

return M

