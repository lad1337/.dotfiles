return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = function(_, opts)
    local preview = opts.preview or {}
    preview.command = 'lolcrab'
    preview.file_path = '~/.dotfiles/config/nvim/dashboard.txt'
    preview.file_width = 69
    preview.file_height = 10
    opts.preview = preview
  end,
  config = function(_, opts)
    require('dashboard').setup(opts)
    -- Refresh dashboard on resize to fix lolcrab rendering
    vim.api.nvim_create_autocmd('VimResized', {
      callback = function()
        if vim.bo.filetype == 'dashboard' then
          vim.cmd('Dashboard')
        end
      end,
    })
  end,
}
