-- Link YAML treesitter groups to match vim syntax highlighting
-- This keeps treesitter active (for SQL injections) but looks like vim syntax
vim.api.nvim_set_hl(0, '@property.yaml', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@string.yaml', { link = 'String' })
vim.api.nvim_set_hl(0, '@number.yaml', { link = 'Number' })
vim.api.nvim_set_hl(0, '@boolean.yaml', { link = 'Boolean' })
vim.api.nvim_set_hl(0, '@constant.yaml', { link = 'Constant' })
vim.api.nvim_set_hl(0, '@punctuation.delimiter.yaml', { link = 'Delimiter' })
vim.api.nvim_set_hl(0, '@punctuation.bracket.yaml', { link = 'Delimiter' })
