vim.cmd.colorscheme 'lunar'
require 'lad1337.set'
require 'lad1337.keys'
require 'lad1337.init_lazy'

require('lazy').setup {
  spec = 'lad1337.lazy',
  change_detection = { notify = true },
}

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = {
    overlay = true,
    highlight_whole_line = false,
    only_current_line = true,
  },
}
