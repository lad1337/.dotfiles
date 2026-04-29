return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    opts = {},
  },
  {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    lazy = true,
    opts = {
      separator = '',
      highlight = true,
      depth_limit = 5,
      lazy_update_context = true,
    },
  },
  { -- winbar breadcrumbs
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },
  { -- floating symbol outline
    'stevearc/aerial.nvim',
    opts = {
      close_on_select = true,
      layout = { default_direction = 'float' },
      float = { relative = 'win' },
      autojump = true,
      show_guides = true,
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '<leader>o',
        function()
          require('aerial').toggle { focus = true }
        end,
        desc = 'Toggle outline',
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>W', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  { -- LSP progress + notifications
    'j-hui/fidget.nvim',
    opts = {
      progress = {
        notification_group = function(msg)
          return 'lsp_progress'
        end,
      },
      notification = {
        override_vim_notify = true,
      },
    },
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { -- column length marker at 100
    'zoriya/virtcolumn.nvim',
    config = function()
      vim.cmd 'set cc=100'
    end,
  },
  { -- color picker / highlighter
    'https://github.com/uga-rosa/ccc.nvim',
    opts = {},
  },
  { 'amansingh-afk/milli.nvim', lazy = false },
  -- {
  --   'nvimdev/dashboard-nvim',
  --   opts = function(_, opts)
  --     local preview = opts.preview or {}
  --     preview.command = 'lolcrab'
  --     preview.file_path = '~/.dotfiles/config/nvim/dashboard.txt'
  --     preview.file_width = 69
  --     preview.file_height = 10
  --     opts.preview = preview
  --   end,
  -- },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'amansingh-afk/milli.nvim' },
    opts = function()
      local splash = require('milli').load { splash = 'gohan' }
      return {
        theme = 'doom',
        config = {
          header = splash.frames[1], -- seed header with frame 0
          center = {
            { icon = '  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
            { icon = '  ', desc = 'Quit', key = 'q', action = 'qa' },
          },
        },
      }
    end,
    config = function(_, opts)
      require('dashboard').setup(opts)
      require('milli').dashboard { splash = 'gohan', loop = true }
    end,
  },
}
