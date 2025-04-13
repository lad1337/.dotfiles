return {
  -- { 'tenxsoydev/tabs-vs-spaces.nvim', config = true },
  { 'NMAC427/guess-indent.nvim', config = true },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = {}
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      ft_parsers = {
        --     javascript = "babel",
        --     javascriptreact = "babel",
        typescript = 'typescript',
        typescriptreact = 'typescript',
        --     vue = "vue",
        --     css = "css",
        --     scss = "scss",
        --     less = "less",
        --     html = "html",
        --     json = "json",
        --     jsonc = "json",
        --     yaml = "yaml",
        --     markdown = "markdown",
        --     ["markdown.mdx"] = "mdx",
        --     graphql = "graphql",
        --     handlebars = "glimmer",
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang-format-18' },
        c = { 'clang-format-18' },
        -- Conform can also run multiple formatters sequentially
        python = { 'black', 'isort' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
      },
    },
  },
}
