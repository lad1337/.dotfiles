local c = require 'lad1337.colors'

-- Neon yellow for type keywords (class, def, etc.)
vim.api.nvim_set_hl(0, '@keyword.coroutine.python', { fg = c.cyan })
