return {
  { 'ianklapouch/wildberries.nvim', name = 'wildberries', priority = 1000 },
  { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  { 'maxmx03/fluoromachine.nvim', lazy = false, priority = 1000 },
  { 'Everblush/nvim', name = 'everblush', priority = 1000 },

  { 'diegoulloao/neofusion.nvim', priority = 1000, config = true },
  { 'ingenarel/cyberpunk-neon.nvim', priority = 1000 },
  { 'hyperb1iss/silkcircuit', lazy = false, priority = 1000 },
  { 'rockerBOO/boo-colorscheme-nvim', lazy = false, priority = 1000 },
  { 'oxidescheme/nvim', name = 'oxid', lazy = false, priority = 1000 },
  { 'LucaasHenrique/irwtsayh.nvim', lazy = false, priority = 1000 },

  { 'vim-scripts/Relaxed-Green', lazy = false, priority = 1000 },
  { 'vim-scripts/DarkZen-Color-Scheme', lazy = false, priority = 1000 },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = {
    'nvim-lua/plenary.nvim',
  }, opts = { signs = false } },
  -- { 'mrjones2014/nvim-ts-rainbow', opts = {} },
  { -- virtcolumn: line length marker
    'zoriya/virtcolumn.nvim',
    config = function()
      vim.cmd 'set cc=100'
    end,
  },
}
