return {
  {
    'fnune/codeactions-on-save.nvim',
    config = function()
      local cos = require 'codeactions-on-save'
      cos.register({ '*.py', '*.go' }, { 'source.organizeImports', 'source.fixAll' })
      cos.register({ '*.ts', '*.tsx' }, { 'source.organizeImports.biome', 'source.fixAll' })
    end,
  },
}
