-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require 'plugins'

lvim.keys.normal_mode["<leader>)"] = "<Plug>(nvim-surround-normal)iw)"
lvim.keys.normal_mode["<leader>("] = "<Plug>(nvim-surround-normal)iw("
lvim.keys.normal_mode["<leader>]"] = "<Plug>(nvim-surround-normal)iw]"
lvim.keys.normal_mode["<leader>["] = "<Plug>(nvim-surround-normal)iw["
lvim.keys.normal_mode["<leader>'"] = "<Plug>(nvim-surround-normal)iw'"
lvim.keys.normal_mode['<leader>"'] = '<Plug>(nvim-surround-normal)iw"'
lvim.keys.visual_mode['<leader>"'] = 'c"<C-R>""<ESC>'
lvim.keys.visual_mode["<leader>'"] = "c'<C-R>\"'<ESC>"

lvim.builtin.treesitter.rainbow.enable = true
lvim.format_on_save.enabled = true
lvim.lsp.on_attach_callback = function(client, bufnr)
  -- …
  require "lsp_signature".on_attach()
  -- …
end

-- https://forum.godotengine.org/t/how-to-get-the-godot-lsp-to-work-with-nvim-lsp/7114/2
-- DAP configuration
local dap = require('dap')
dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}


-- LSP Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  local _notify = client.notify

  client.notify = function(method, params)
    if method == 'textDocument/didClose' then
      -- Godot doesn't implement didClose yet
      return
    end
    _notify(method, params)
  end
end

-- LSP Config for Godot

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require 'lspconfig'.gdscript.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = { "gd", "gdscript", "gdscript3" },
}
