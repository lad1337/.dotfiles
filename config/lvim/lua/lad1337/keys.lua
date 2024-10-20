lvim.keys.normal_mode["<leader>)"] = "<Plug>(nvim-surround-normal)iw)"
lvim.keys.normal_mode["<leader>("] = "<Plug>(nvim-surround-normal)iw("
lvim.keys.normal_mode["<leader>]"] = "<Plug>(nvim-surround-normal)iw]"
lvim.keys.normal_mode["<leader>["] = "<Plug>(nvim-surround-normal)iw["
lvim.keys.normal_mode["<leader>'"] = "<Plug>(nvim-surround-normal)iw'"
lvim.keys.normal_mode['<leader>"'] = '<Plug>(nvim-surround-normal)iw"'
lvim.keys.visual_mode['<leader>"'] = 'c"<C-R>""<ESC>'
lvim.keys.visual_mode["<leader>'"] = "c'<C-R>\"'<ESC>"

local opts = { noremap = true, silent = true }
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

-- https://github.com/LunarVim/LunarVim/issues/3351#issuecomment-1902514210
lvim.builtin.which_key.mappings['f'] = {
  function()
    require("lvim.core.telescope.custom-finders").find_project_files { previewer = true, show_untracked = true }
  end,
  "Find File",
}
