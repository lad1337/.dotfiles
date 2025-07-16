return {
  'nvimdev/dashboard-nvim',
  opts = function(_, opts)
    local preview = opts.preview or {}
    preview.command = 'lolcrab'
    preview.file_path = '~/.dotfiles/config/nvim/dashboard.txt'
    preview.file_width = 69
    preview.file_height = 10
    opts.preview = preview
  end,
}
