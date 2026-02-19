vim.filetype.add {
  extension = {
    dsl = 'structurizr',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'structurizr' },
  callback = function(args)
    vim.treesitter.start(args.buf, 'structurizr')
  end,
})
vim.treesitter.language.register('structurizr', { 'dsl' })

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'TSUpdate',
--   callback = function()
--     require('nvim-treesitter.parsers').structurizr = {
--       install_info = {
--         url = 'https://github.com/josteink/tree-sitter-structurizr',
--         revision = '82b63b2d13d5020d48f0e66621c9ed4d826d6a37',
--         branch = 'master',
--         queries = 'queries',
--       },
--     }
--   end,
-- })
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.structurizr = {
  install_info = {
    url = 'https://github.com/josteink/tree-sitter-structurizr',
    -- url = '/Users/lad1337/workspace/tree-sitter-structurizr',
    revision = '82b63b2d13d5020d48f0e66621c9ed4d826d6a37',
    files = { 'src/parser.c' }, -- This is the missing piece
    branch = 'master',
    queries = 'queries',
  },
  filetype = 'dsl',
}
