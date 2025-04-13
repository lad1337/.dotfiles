return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
  },
  {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    lazy = true,
    opts = {
      separator = '',
      highlight = true,
      depth_limit = 5,
      -- icons = LazyVim.config.icons.kinds,
      lazy_update_context = true,
    },
  },
  { -- top bar for navic
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    'chrisgrieser/nvim-origami',
    dependencies = { 'kevinhwang91/nvim-ufo' },
    lazy = true,
    event = 'VeryLazy', -- later or on keypress would prevent saving folds event = 'VeryLazy',
    opts = {
      foldKeymaps = {
        setup = true, -- modifies `h` and `l`
        hOnlyOpensOnFirstColumn = true,
      },
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      close_on_select = true,
      layout = {
        default_direction = 'float',
      },
      float = {
        relative = 'win',
      },
      autojump = true,
      show_guides = true,
    },
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = { -- Example mapping to toggle outline
      {
        '<leader>o',
        function()
          require('aerial').toggle { focus = true }
        end,
        desc = 'Toggle outline',
      },
    },
  },
  --   {
  --   'anuvyklack/pretty-fold.nvim',
  --   lazy = true,
  --   event = 'BufReadPost',
  --   opts = {},
  -- },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async', 'luukvbaal/statuscol.nvim' },
    config = function(_, opts)
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
        pattern = opts.filetype_exclude,
        callback = function()
          require('ufo').detach()
        end,
      })

      require('ufo').setup(opts)
    end,
    opts = {
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󱞡 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end,
    },
  },
  {
    'luukvbaal/statuscol.nvim',
    lazy = true,
    config = function()
      local builtin = require 'statuscol.builtin'
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:󰡏]]
      require('statuscol').setup {
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          {
            sign = { namespace = { 'Diagnostics' }, maxwidth = 2, auto = true },
            click = 'v:lua.ScSa',
          },
          { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
          {
            sign = { namespace = { 'gitsigns' }, maxwidth = 1, auto = true, colwidth = 1, fillchar = ' ' },
            click = 'v:lua.ScSa',
          },
          {
            sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
            click = 'v:lua.ScSa',
          },
        },
      }
    end,
  },
}
