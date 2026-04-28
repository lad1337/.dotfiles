return {
  { -- Treesitter for nvim 0.12+ (main branch)
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- Install parsers (no ensure_installed in main branch)
      local parsers = { 'bash', 'c', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'vue', 'typescript', 'javascript', 'css', 'html', 'json', 'yaml', 'python', 'go', 'rust' }
      for _, parser in ipairs(parsers) do
        pcall(function() require('nvim-treesitter').install(parser) end)
      end
    end,
    -- config = function(_, opts)
    --   local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    --   parser_config.structurizr = {
    --     install_info = {
    --       -- url = 'https://github.com/josteink/tree-sitter-structurizr',
    --       url = '/Users/lad1337/workspace/tree-sitter-structurizr',
    --       revision = '82b63b2d13d5020d48f0e66621c9ed4d826d6a37',
    --       branch = 'master',
    --       queries = 'queries',
    --     },
    --     filetype = 'dsl',
    --   }
    --   require('nvim-treesitter.configs').setup(opts)
    -- end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
