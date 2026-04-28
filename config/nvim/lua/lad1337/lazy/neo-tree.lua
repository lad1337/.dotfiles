-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  -- load it on start to make it replace netrw
  lazy = false,
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '§', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    auto_clean_after_session_restore = true,

    filesystem = {
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = 'open_current',
      filtered_items = {
        always_show = { '.env', '.env.example', '.gitignore', '.zshrc' },
        always_show_by_pattern = { '.*.yaml', '.*.yml' },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['§'] = 'close_window',
          ['l'] = 'open',
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
        },
      },
    },
  },
}
