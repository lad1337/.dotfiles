return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      -- https://forum.godotengine.org/t/how-to-get-the-godot-lsp-to-work-with-nvim-lsp/7114/2
      -- DAP configuration
      local dap = require 'dap'
      dap.adapters.godot = {
        type = 'server',
        host = '127.0.0.1',
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = 'godot',
          request = 'launch',
          name = 'Launch scene',
          scene = function()
            local path = vim.fn.input {
              prompt = 'Path to scene: ',
              default = vim.fn.getcwd() .. '/',
              completion = 'file',
            }
            return (path and path ~= '') and path or dap.ABORT
          end,
        },
      }
    end,
  },
  {
    'nvim-neotest/neotest',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
          },
          require 'neotest-plenary',
        },
      }
    end,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-python',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F12>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F8>', dap.terminate, { desc = 'Debug: Terminate' })
    end,
  },
}
