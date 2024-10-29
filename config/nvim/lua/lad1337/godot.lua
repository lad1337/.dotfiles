-- LSP Mappings.
-- https://forum.godotengine.org/t/how-to-get-the-godot-lsp-to-work-with-nvim-lsp/7114/2
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  local bufopts = { noremap = true, silent = true }
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

local lsp_flags = {
  debounce_text_changes = 150,
}

require('lspconfig').gdscript.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  formatCommand = 'gdformat -l 80 -',
  formatStdin = true,
  filetypes = { 'gd', 'gdscript', 'gdscript3' },
}
-- https://github.com/wowthatsabigturtle/vim-config/blob/1fca3ab01229604695e5402474a394ab37ffef5f/init.lua#L520C1-L528C4
-- Enable neovim to be the external editor for Godot, if the cwd has a project.godot file
if vim.fn.filereadable(vim.fn.getcwd() .. '/project.godot') == 1 then
  local addr = vim.fn.expand '$HOME/.cache/godot.pipe'
  if vim.fn.has 'win32' == 1 then
    -- Windows can't pipe so use localhost. Make sure this is configured in Godot
    addr = '127.0.0.1:6004'
  end

  if pcall(vim.fn.serverstart, addr) then
    vim.notify('Godot pipe connected', 'success')
  else
    vim.notify('Godot pipe already connected on another instance', 'error')
  end
end
