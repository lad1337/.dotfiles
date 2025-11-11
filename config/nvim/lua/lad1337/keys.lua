-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local k = function(mode, lhs, rhs, desc)
  local opts = { desc = desc }
  if type(desc) == 'table' then
    opts = desc
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
k('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

k('n', '<leader>q', vim.cmd.quit, 'Quit')
k('n', '<leader>w', vim.cmd.write, 'Write')

k('n', '<leader>S', function()
  vim.cmd ':vsplit +:bprev'
end, 'Split Previous Buffer')

k('n', 'H', ':tabprevious<CR>', 'Previous tab')
k('n', 'L', ':tabnext<CR>', 'Next tab')

k('n', '<leader>sp', ':SessionSearch<CR>', 'Search Projects/Sessions')

k('n', '<C-p>', 'viwp', 'Paste over current word')
-- k('n', '<space>p', 'gpd')
k('n', '<C-s>', split_definition_vertical, 'Open definition in split')
k('n', '<leader>QQ', ':SessionDisableAutoSave<CR>:SessionDelete<CR>:wa<CR>:qa<CR>', 'Kill this session!')
k('n', '<leader>CC', ':%bd|Neotree<CR>', 'Kill this session!')
-- k('n', '<C-a>', [[m'?^\s*def\<CR>iasync <ESC><C-o>]], 'Make func async')
-- k('n', '<C-A>', "m'Biawait <ESC><C-o>", 'Make begining await')
