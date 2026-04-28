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
-- Custom parser config requires nvim-treesitter, disabled for nvim 0.12
-- To use structurizr parser, install manually:
--   cd ~/.local/share/nvim/site/parser
--   git clone https://github.com/josteink/tree-sitter-structurizr
--   cd tree-sitter-structurizr && cc -shared -o structurizr.so -I./src src/parser.c -O2
