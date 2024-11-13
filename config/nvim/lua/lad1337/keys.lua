-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
local k = function(mode, lhs, rhs, desc)
  opts = { desc = desc }
  if type(desc) == 'table' then
    opts = desc
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

k('n', '<Esc>', '<cmd>nohlsearch<CR>')
k('n', '|', '<cmd>Trouble symbols toggle focus=true<cr>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
k('n', '<leader>i', function()
  vim.diagnostic.open_float(nil, {
    focus = false,
    scope = 'cursor',
    border = 'rounded',
    max_width = 100,
  })
end, 'Diagnostics float')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
k('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
k('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
k('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
k('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
k('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
k('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

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

k('n', '<leader>(', '<Plug>(nvim-surround-normal)iw(', 'Surround word with )')
k('n', '<leader>)', '<Plug>(nvim-surround-normal)iw)', 'Surround work with (')
k('n', '<leader>]', '<Plug>(nvim-surround-normal)iw]', 'Surround word with ]')
k('n', '<leader>[', '<Plug>(nvim-surround-normal)iw[', 'Surround word with [')
k('n', "<leader>'", "<Plug>(nvim-surround-normal)iw'", "Surround word with '")
k('n', '<leader>"', '<Plug>(nvim-surround-normal)iw"', 'Surround word with "')

k('n', '<leader>q', vim.cmd.quit, 'Quit')
k('n', '<leader>w', vim.cmd.write, 'Write')

k('n', '<leader>SS', function()
  vim.cmd ':vsplit +:bprev'
end)
-- vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
-- k('n', '<leader>a', '<cmd>lspsaga code_action<cr>', 'code action')
-- k('n', '[e', '<cmd>lspsaga diagnostic_jump_next<cr>', 'next diagnostic')
-- k('n', ']e', '<cmd>lspsaga diagnostic_jump_prev<cr>', 'prev diagnostic')
