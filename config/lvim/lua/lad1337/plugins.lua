lvim.plugins = {
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup({
        hint_prefix = {
          above = "↙ ", -- when the hint is on the line above the current line
          current = "← ", -- when the hint is on the same line
          below = "↖ " -- when the hint is on the line below the current line
        }
      })
    end,
  },
  { "mrjones2014/nvim-ts-rainbow", },
  { "lad1337/underwater-mod", },
  { 'zoriya/virtcolumn.nvim',      config = function() vim.cmd("set cc=100") end },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    opts = {},
  },
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
      vim.cmd("let g:minimap_git_colors = 1")
      lvim.builtin.which_key.mappings["m"] = {
        "<cmd>MinimapToggle<CR>", "MinimapToggle"
      }
    end
  },
  -- if ever want to try leap.nvim again check https://github.com/LazyVim/LazyVim/issues/2379#issuecomment-1898491969
}
