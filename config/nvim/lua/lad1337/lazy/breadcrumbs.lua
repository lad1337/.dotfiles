return {
  {
    'SmiteshP/nvim-navic',
    config = function()
      require('nvim-navic').setup { lsp = {
        auto_attach = true,
        preference = nil,
      } }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup()
    end,
    branch = 'main',
  },
}
