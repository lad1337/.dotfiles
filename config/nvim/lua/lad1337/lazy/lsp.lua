return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      -- Use lspconfig names - mason-lspconfig maps them internally
      require('mason-lspconfig').setup {
        ensure_installed = {
          'ts_ls',
          'vue_ls',
          'eslint',
          'pyright',
          'gopls',
          'rust_analyzer',
          'lua_ls',
          'jsonls',
          'yamlls',
          'helm_ls',
          'clangd',
          'omnisharp',
        },
        automatic_installation = true,
      }
    end,
  },
  {
    'folke/lazydev.nvim',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    build = 'rm -f doc/tags', -- Prevent git checkout conflicts
    config = function()
      require('lsp_signature').setup {
        hint_prefix = {
          above = '↙ ',
          current = '← ',
          below = '↖ ',
        },
      }
    end,
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'rmagatti/goto-preview',
    dependencies = { 'rmagatti/logger.nvim' },
    event = 'BufEnter',
    config = function()
      vim.keymap.set('n', 'gp', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
      require('goto-preview').setup {
        height = 20,
        default_mappings = true,
        post_open_hook = function(bufnr, winnr)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>:q<cr>', {})
        end,
      }
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {
        lightbulb = { enable = false, virtual_text = false, sign = false },
        ui = { code_action = ' 󱐋' },
        diagnostic = { extend_relatedInformation = true },
      }
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  },
  -- nvim-lspconfig provides server definitions for vim.lsp.config
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'SmiteshP/nvim-navic' },
      { 'kevinhwang91/nvim-ufo' },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- LspAttach autocmd for keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lad1337-lsp-attach', { clear = true }),
        callback = function(event)
          require('lsp_signature').on_attach()
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>Ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', '<cmd>Lspsaga rename<cr>', '[R]e[n]ame')
          map('<leader>i', '<cmd>Lspsaga show_buf_diagnostics<cr>', 'Buf Diagnostics')
          map('<leader>I', '<cmd>Lspsaga show_workspace_diagnostics<cr>', 'Workspace Diagnostics')
          map('K', '<cmd>Lspsaga hover_doc<cr>', 'HoverDoc')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lad1337-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lad1337-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lad1337-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Capabilities with nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Native nvim 0.11+/0.12 LSP configuration
      -- Server configs using vim.lsp.config()
      -- Install servers manually:
      --   npm i -g typescript-language-server typescript @vue/language-server
      --   npm i -g vscode-langservers-extracted yaml-language-server
      --   brew install lua-language-server pyright rust-analyzer gopls

      -- Vue TypeScript plugin location (bundled with vue-language-server)
      local vue_ts_plugin = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

      -- TypeScript/JavaScript with Vue plugin for .vue file support
      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_ts_plugin,
              languages = { 'vue' },
            },
          },
        },
      })

      -- Vue language server for template/style support
      vim.lsp.config('vue_ls', {
        capabilities = capabilities,
      })

      -- ESLint
      vim.lsp.config('eslint', {
        capabilities = capabilities,
      })

      -- Python
      vim.lsp.config('pyright', {
        capabilities = capabilities,
      })

      -- Go
      vim.lsp.config('gopls', {
        capabilities = capabilities,
      })

      -- Rust
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
      })

      -- Lua
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      })

      -- JSON
      vim.lsp.config('jsonls', {
        capabilities = capabilities,
        filetypes = { 'json', 'jsonc' },
      })

      -- YAML
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
      })

      -- Helm
      vim.lsp.config('helm_ls', {
        capabilities = capabilities,
      })

      -- C/C++
      vim.lsp.config('clangd', {
        capabilities = capabilities,
      })

      -- C# / .NET
      vim.lsp.config('omnisharp', {
        capabilities = capabilities,
      })

      -- Enable all configured servers
      vim.lsp.enable {
        'ts_ls',
        'vue_ls',
        'eslint',
        'pyright',
        'gopls',
        'rust_analyzer',
        'lua_ls',
        'jsonls',
        'yamlls',
        'helm_ls',
        'clangd',
        'omnisharp',
      }
    end,
  },
}
