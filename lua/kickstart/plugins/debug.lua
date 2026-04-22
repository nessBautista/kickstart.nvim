-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',

    -- Inline variable values while debugging
    'theHamsta/nvim-dap-virtual-text',
  },
  keys = {
    -- Basic debugging keymaps (Magic Keyboard friendly - no F-keys!)
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>dn',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over (Next)',
    },
    {
      '<leader>do',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Conditional Breakpoint',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle UI',
    },
    {
      '<leader>dm',
      function()
        require('dap-python').test_method()
      end,
      desc = 'Debug: Python Test Method',
    },
    {
      '<leader>df',
      function()
        require('dap-python').test_class()
      end,
      desc = 'Debug: Python Test Class',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve', -- Go
        'debugpy', -- Python
        'codelldb', -- Swift, C, C++, Rust (using LLDB)
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    -- Enhanced breakpoint visibility
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#ff0000', bold = true })  -- Bright red
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffff00', bold = true })   -- Bright yellow
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreak', numhl = 'DapBreak' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '◉', texthl = 'DapBreak', numhl = 'DapBreak' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '✖', texthl = 'DapBreak', numhl = 'DapBreak' })
    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStop', numhl = 'DapStop' })
    vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapBreak', numhl = 'DapBreak' })

    require('nvim-dap-virtual-text').setup {}

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- Python specific config
    -- Prefer a uv/venv-managed interpreter from the current project, falling
    -- back to system python3 when no venv is detected.
    local function venv_python()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      elseif vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      end
      return 'python3'
    end

    require('dap-python').setup(venv_python())

    -- Add custom Python configurations for individual scripts
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Launch current file',
      program = '${file}',
      console = 'integratedTerminal',
      pythonPath = venv_python,
    })

    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Launch file with args',
      program = '${file}',
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")
      end,
      console = 'integratedTerminal',
      pythonPath = venv_python,
    })

    -- Swift/LLDB specific config
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
      },
    }

    -- Apple's LLDB with full Swift support
    dap.adapters.lldb = {
      type = 'executable',
      command = '/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap',
      name = 'lldb',
    }

    dap.configurations.swift = {
      {
        name = 'Launch Swift (lldb)',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
      {
        name = 'Launch Swift (codelldb)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
}
