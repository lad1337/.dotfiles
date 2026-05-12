return {
  { 'amansingh-afk/milli.nvim', lazy = false },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'amansingh-afk/milli.nvim' },
    opts = function()
      local selection = { 'gohan', 'fingers', 'lain' }
      local it = selection[math.random(#selection)]
      local splash = require('milli').load { splash = it }
      return {
        theme = 'doom',
        config = {
          header = splash.frames[1], -- seed header with frame 0
          center = {
            { desc = 'Find File', key = 'f', action = 'Telescope find_files' },
            { desc = 'Quit', key = 'q', action = 'qa' },
            { desc = it, desc_hl = 'SpecialKey' },
          },
        },
      }
    end,
    config = function(_, opts)
      require('dashboard').setup(opts)
      local c = opts['config']['center']
      require('milli').dashboard { splash = c[#c]['desc'], loop = true }
    end,
  },
}
