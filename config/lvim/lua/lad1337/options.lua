vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
-- also used for lsp_lines plugin
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    only_current_line = true,
    overlay = true,
    strip = true,
  },
})

lvim.builtin.treesitter.rainbow.enable = true
lvim.format_on_save.enabled = true
lvim.builtin.telescope = {
  active = true,
  defaults = {
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        width = 0.8,
        prompt_position = "top",
      },
    },
    path_display = { truncate = 2 }
  }
}
