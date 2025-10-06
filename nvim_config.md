This file is a merged representation of the entire codebase, combined into a single document by Repomix.

# File Summary

## Purpose
This file contains a packed representation of the entire repository's contents.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded

## Additional Info

# Directory Structure
```
.github/
  ISSUE_TEMPLATE/
    bug_report.md
  workflows/
    stylua.yml
  pull_request_template.md
doc/
  kickstart.txt
lua/
  custom/
    plugins/
      init.lua
      render-markdown.lua
  kickstart/
    plugins/
      autopairs.lua
      debug.lua
      gitsigns.lua
      indent_line.lua
      lint.lua
      neo-tree.lua
    health.lua
.gitignore
.stylua.toml
DEBUG_GUIDE.md
init.lua
LICENSE.md
NAVIGATION.md
README.md
```

# Files

## File: .github/ISSUE_TEMPLATE/bug_report.md
````markdown
---
name: Bug report
about: Create a report to help us improve
title: ''
labels: ''
assignees: ''

---

<!-- Any bug report not following this template will be immediately closed. Thanks -->

## Before Reporting an Issue
- I have read the kickstart.nvim README.md.
- I have read the appropriate plugin's documentation.
- I have searched that this issue has not been reported before.

- [ ] **By checking this, I confirm that the above steps are completed. I understand leaving this unchecked will result in this report being closed immediately.**

## Describe the bug
<!-- A clear and concise description of what the bug is. -->

## To Reproduce
<!-- Steps to reproduce the behavior. -->
1. ...

## Desktop
<!-- please complete the following information. -->
- OS:
- Terminal:

## Neovim Version
<!-- Output of running `:version` from inside of neovim. -->

```
```
````

## File: .github/workflows/stylua.yml
````yaml
# Check Lua Formatting
name: Check Lua Formatting
on: pull_request_target

jobs:
  stylua-check:
    if: github.repository == 'nvim-lua/kickstart.nvim'
    name: Stylua Check
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v2
        with:
          ref: ${{ github.event.pull_request.head.sha }}
      - name: Stylua Check
        uses: JohnnyMorganz/stylua-action@v3
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          version: latest
          args: --check .
````

## File: .github/pull_request_template.md
````markdown
***************************************************************************
**NOTE**
Please verify that the `base repository` above has the intended destination!
Github by default opens Pull Requests against the parent of a forked repository.
If this is your personal fork and you didn't intend to open a PR for contribution
to the original project then adjust the `base repository` accordingly.
**************************************************************************
````

## File: doc/kickstart.txt
````
================================================================================
INTRODUCTION                                                  *kickstart.nvim*

Kickstart.nvim is a project to help you get started on your neovim journey.

                                                            *kickstart-is-not*
It is not:
- Complete framework for every plugin under the sun
- Place to add every plugin that could ever be useful

                                                                *kickstart-is*
It is:
- Somewhere that has a good start for the most common "IDE" type features:
    - autocompletion
    - goto-definition
    - find references
    - fuzzy finding
    - and hinting at what more can be done :)
- A place to _kickstart_ your journey.
    - You should fork this project and use/modify it so that it matches your
      style and preferences. If you don't want to do that, there are probably
      other projects that would fit much better for you (and that's great!)!

 vim:tw=78:ts=8:ft=help:norl:
````

## File: lua/custom/plugins/init.lua
````lua
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {}
````

## File: lua/custom/plugins/render-markdown.lua
````lua
-- Render markdown with rich formatting
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
````

## File: lua/kickstart/plugins/autopairs.lua
````lua
-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
}
````

## File: lua/kickstart/plugins/debug.lua
````lua
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
    require('dap-python').setup('python3')

    -- Swift/LLDB specific config
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
      },
    }

    dap.configurations.swift = {
      {
        name = 'Launch',
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
````

## File: lua/kickstart/plugins/gitsigns.lua
````lua
-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
}
````

## File: lua/kickstart/plugins/indent_line.lua
````lua
return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}
````

## File: lua/kickstart/plugins/lint.lua
````lua
return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
````

## File: lua/kickstart/plugins/neo-tree.lua
````lua
-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
````

## File: lua/kickstart/health.lua
````lua
--[[
--
-- This file is not required for your own configuration,
-- but helps people determine if their system is setup correctly.
--
--]]

local check_version = function()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.10-dev') then
    vim.health.ok(string.format("Neovim version is: '%s'", verstr))
  else
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
  end
end

local check_external_reqs = function()
  -- Basic utils: `git`, `make`, `unzip`
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end

  return true
end

return {
  check = function()
    vim.health.start 'kickstart.nvim'

    vim.health.info [[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

  Fix only warnings for plugins and languages you intend to use.
    Mason will give warnings for languages that are not installed.
    You do not need to install, unless you want to use those languages!]]

    local uv = vim.uv or vim.loop
    vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))

    check_version()
    check_external_reqs()
  end,
}
````

## File: .gitignore
````
tags
test.sh
.luarc.json
nvim

spell/
lazy-lock.json
````

## File: .stylua.toml
````toml
column_width = 160
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 2
quote_style = "AutoPreferSingle"
call_parentheses = "None"
````

## File: DEBUG_GUIDE.md
````markdown
# Neovim Debugging Guide

## Quick Reference

**Leader key**: `<Space>`

---

## Universal Debug Keymaps

These keymaps work for **all languages** (Python, Swift, Go, etc.):

| Keymap | Action | Description |
|--------|--------|-------------|
| `<Space>dc` | **Debug Continue** | Start debugging or continue execution |
| `<Space>di` | **Debug step Into** | Step into function calls |
| `<Space>dn` | **Debug Next** | Step over (execute current line) |
| `<Space>do` | **Debug Out** | Step out of current function |
| `<Space>dt` | **Debug Terminate** | Stop debugging session |
| `<Space>du` | **Debug UI** | Toggle debug UI panels |
| `<Space>b` | **Breakpoint** | Toggle breakpoint on current line |
| `<Space>B` | **Conditional Breakpoint** | Set breakpoint with condition |

---

## Prerequisites

### Python Debugging

1. **Python 3 installed**:
   ```bash
   python3 --version
   ```

2. **debugpy will be auto-installed** by Mason when you restart nvim

3. **For virtual environments**, you may need to configure the Python path:
   ```lua
   -- Add to your config if needed
   require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
   ```

### Swift Debugging

1. **Xcode and Swift toolchain installed**:
   ```bash
   swift --version
   # Verify sourcekit-lsp is available
   xcrun --find sourcekit-lsp
   ```

2. **codelldb will be auto-installed** by Mason when you restart nvim

3. **Swift LSP (sourcekit-lsp)** is configured to use your Xcode installation automatically

4. **Compile your Swift project first** (debugger needs an executable):
   ```bash
   swift build
   # Executable will typically be in .build/debug/YourProjectName
   ```

---

## Python Debugging Workflow

### 1. Setup (First Time Only)

After restarting nvim, Mason will automatically install:
- `debugpy` (Python debugger)
- `pyright` (Python LSP for code intelligence)

Verify installation:
```vim
:Mason
```

### 2. Basic Python Debugging

**Example: Debug a Python script**

1. Open your Python file:
   ```vim
   nvim main.py
   ```

2. Set a breakpoint (move cursor to desired line):
   ```
   <Space>b
   ```

3. Start debugging:
   ```
   <Space>dc
   ```

4. Use step commands:
   - `<Space>dn` - Execute current line
   - `<Space>di` - Step into function
   - `<Space>do` - Step out of function

5. Inspect variables in the Debug UI (automatically opens)

6. Continue or terminate:
   - `<Space>dc` - Continue to next breakpoint
   - `<Space>dt` - Stop debugging

### 3. Debug Configuration

For more complex setups (e.g., with arguments), you can create a `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "python",
      "request": "launch",
      "name": "Python: Current File",
      "program": "${file}",
      "console": "integratedTerminal",
      "args": ["arg1", "arg2"]
    }
  ]
}
```

---

## Swift Debugging Workflow

### 1. Setup (First Time Only)

After restarting nvim, Mason will automatically install:
- `codelldb` (LLDB-based debugger for Swift/C/C++/Rust)

**Note**: Swift LSP (sourcekit-lsp) will use your system-installed version from Xcode.

### 2. Basic Swift Debugging

**Example: Debug a Swift executable**

1. **Build your project first**:
   ```bash
   swift build
   ```

2. Open your Swift file:
   ```vim
   nvim main.swift
   ```

3. Set breakpoints:
   ```
   <Space>b
   ```

4. Start debugging:
   ```
   <Space>dc
   ```

5. **When prompted, enter the path to your executable**:
   ```
   Path to executable: .build/debug/MyApp
   ```

6. Use debug commands as normal

### 3. Swift Debug Configuration

For repeated debugging, create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "codelldb",
      "request": "launch",
      "name": "Debug Swift App",
      "program": "${workspaceFolder}/.build/debug/MyApp",
      "args": [],
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

---

## Debug UI Overview

When you start debugging or press `<Space>du`, you'll see panels:

### Panels
- **Scopes** - Local variables and their values
- **Watches** - Custom expressions to monitor
- **Call Stack** - Function call hierarchy
- **Breakpoints** - List of all breakpoints
- **Console/REPL** - Execute code in debug context

### Navigation in Debug UI
- `<C-h/j/k/l>` - Move between panels
- `q` - Close a panel
- `<Space>du` - Toggle entire debug UI

---

## Common Debugging Workflows

### Workflow 1: Quick Script Debugging (Python)
1. Open file
2. `<Space>b` on suspect line
3. `<Space>dc` to start
4. `<Space>dn` to step through
5. Check variables in Scopes panel
6. `<Space>dt` when done

### Workflow 2: Function Deep Dive
1. Set breakpoint before function call
2. `<Space>dc` to start
3. `<Space>di` to step into function
4. Inspect parameters in Scopes
5. `<Space>dn` to step through function
6. `<Space>do` to return to caller

### Workflow 3: Conditional Debugging
1. `<Space>B` on loop or frequent code
2. Enter condition: `i == 5` or `user.name == "admin"`
3. `<Space>dc` - stops only when condition is true
4. Debug the specific case

### Workflow 4: Post-Mortem Debugging
1. Code crashes or raises exception
2. `<Space>du` to open debug UI
3. Check Call Stack panel
4. Review variable values at crash
5. Set breakpoints and retry

---

## Troubleshooting

### Python Issues

**Problem**: "No module named debugpy"
```bash
# Install manually if needed
python3 -m pip install debugpy
```

**Problem**: Wrong Python interpreter
```lua
-- In your config, specify the correct Python:
require('dap-python').setup('/path/to/your/python3')
```

**Problem**: Breakpoints not hitting
- Ensure file is saved before debugging
- Check that you're running the correct file
- Verify debugpy is installed: `:Mason`

### Swift Issues

**Problem**: "Cannot find executable"
- Build first: `swift build`
- Check path: `.build/debug/YourProjectName`
- Make sure you're in the project root

**Problem**: "codelldb not found"
- Check Mason: `:Mason`
- Manually install: `:MasonInstall codelldb`
- Restart nvim

**Problem**: Symbols not loading
- Build with debug symbols: `swift build -c debug`
- Ensure Xcode Command Line Tools are installed: `xcode-select --install`
- Verify sourcekit-lsp is in PATH: `xcrun --find sourcekit-lsp`

### General Issues

**Problem**: Debug UI not opening
- Manually toggle: `<Space>du`
- Check DAP installation: `:checkhealth dap`

**Problem**: Keymaps not working
- Verify leader key: `<Space>` should be your leader
- Check keymap conflicts: `<Space>sk` then search "debug"

---

## Advanced Configuration

### Custom Keymaps

Add to your config if you want different keymaps:

```lua
vim.keymap.set('n', '<leader>dr', function() require('dap').restart() end, { desc = 'Debug: Restart' })
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Debug: Run Last' })
```

### Multiple Debug Configurations

Create project-specific configs in `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Flask App",
      "type": "python",
      "request": "launch",
      "module": "flask",
      "env": {"FLASK_APP": "app.py"},
      "args": ["run", "--no-debugger"]
    },
    {
      "name": "Swift: Tests",
      "type": "codelldb",
      "request": "launch",
      "program": "${workspaceFolder}/.build/debug/MyAppTests"
    }
  ]
}
```

Select configuration when starting:
```
<Space>dc
```
Then choose from the list.

---

## Resources

- `:help dap` - Full DAP documentation
- `:help dap-python` - Python-specific help
- `:checkhealth dap` - Verify debug setup
- [nvim-dap GitHub](https://github.com/mfussenegger/nvim-dap)
- [debugpy docs](https://github.com/microsoft/debugpy)
- [codelldb docs](https://github.com/vadimcn/codelldb)

---

## Quick Access

From nvim: `<Space>sn` then type "DEBUG"
````

## File: init.lua
````lua
--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        pyright = {}, -- Python LSP
        sourcekit = { -- Swift LSP (uses Xcode's sourcekit-lsp, not Mason)
          cmd = { 'sourcekit-lsp' }, -- Uses system PATH (from Xcode)
        },
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})

      -- Filter out servers that aren't available via Mason (e.g., sourcekit from Xcode)
      local mason_exclude = { 'sourcekit' }
      ensure_installed = vim.tbl_filter(function(server)
        return not vim.tbl_contains(mason_exclude, server)
      end, ensure_installed)

      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

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
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
````

## File: LICENSE.md
````markdown
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
````

## File: NAVIGATION.md
````markdown
# Neovim Navigation Guide

## Quick Reference

**Leader key**: `<Space>`

---

## 1. File Tree Explorer

### Neo-tree (Directory Visualization)
- **`\`** (backslash) - **Toggle Neo-tree** - Open/close file tree sidebar

### Neo-tree Navigation (when open)
- `j/k` or arrow keys - Move up/down
- `<CR>` (Enter) - Open file/expand directory
- `\` - Close Neo-tree
- `a` - Add new file/directory
- `d` - Delete file/directory
- `r` - Rename file/directory
- `y` - Copy file/directory
- `x` - Cut file/directory
- `p` - Paste file/directory
- `R` - Refresh tree
- `H` - Toggle hidden files
- `?` - Show help (all keymaps)

---

## 2. Finding Files & Content

### File Navigation
- `<Space>sf` - **Search Files** - Fuzzy find any file in your project
- `<Space>sn` - **Search Neovim config** - Quickly open nvim config files
- `<Space>s.` - **Recent Files** - Recently opened files
- `<Space><Space>` - **Switch Buffers** - Jump between open files

### Content Search
- `<Space>sg` - **Live Grep** - Search text across all files
- `<Space>sw` - **Search Word** - Find current word under cursor in project
- `<Space>s/` - **Search in Open Files** - Grep only in currently open buffers
- `<Space>/` - **Fuzzy Search Current Buffer** - Search within the file you're editing

### Other Searches
- `<Space>sh` - **Search Help** - Search nvim help documentation
- `<Space>sk` - **Search Keymaps** - Find keyboard shortcuts
- `<Space>ss` - **Select Telescope** - Browse all Telescope pickers
- `<Space>sr` - **Resume** - Reopen last Telescope search

---

## 3. Code Navigation (LSP)

### Jump to Definitions
- `grd` - **Goto Definition** - Jump to where a function/variable is defined
- `gri` - **Goto Implementation** - Jump to the implementation
- `grt` - **Goto Type Definition** - Jump to type definition
- `grD` - **Goto Declaration** - Jump to declaration (e.g., C header)

### Find References & Symbols
- `grr` - **Goto References** - Find all places this is used
- `gO` - **Document Symbols** - Fuzzy find all symbols in current file
- `gW` - **Workspace Symbols** - Fuzzy find symbols in entire project

### Code Actions
- `grn` - **Rename** - Rename variable/function across project
- `gra` - **Code Action** - Show available code actions (fixes, refactors)

### Back Navigation
- `<C-t>` - **Jump Back** - Return to previous location (after goto commands)
- `<C-o>` - **Older position** - Navigate backward in jump list
- `<C-i>` - **Newer position** - Navigate forward in jump list

---

## 4. Basic Movement

### Character/Line Movement
- `h/j/k/l` - Left/Down/Up/Right
- `w` - Next word start
- `b` - Previous word start
- `e` - Next word end
- `0` - Start of line
- `^` - First non-blank character
- `$` - End of line
- `gg` - Top of file
- `G` - Bottom of file
- `{number}G` - Go to line number (e.g., `42G`)

### Screen Movement
- `H` - Top of screen (High)
- `M` - Middle of screen
- `L` - Bottom of screen (Low)
- `<C-u>` - Scroll up half page
- `<C-d>` - Scroll down half page
- `<C-b>` - Scroll up full page
- `<C-f>` - Scroll down full page
- `zt` - Put cursor line at top
- `zz` - Put cursor line at center
- `zb` - Put cursor line at bottom

### Search Movement
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` - Next match
- `N` - Previous match
- `*` - Search for word under cursor (forward)
- `#` - Search for word under cursor (backward)
- `<Esc>` - Clear search highlights

---

## 5. Window & Split Navigation

### Moving Between Windows
- `<C-h>` - Move to left window
- `<C-j>` - Move to bottom window
- `<C-k>` - Move to top window
- `<C-l>` - Move to right window

### Creating Splits
- `:split` or `:sp` - Horizontal split
- `:vsplit` or `:vs` - Vertical split
- `:split {file}` - Open file in horizontal split
- `:vsplit {file}` - Open file in vertical split

### Managing Windows
- `<C-w>=` - Make all windows equal size
- `<C-w>_` - Maximize height
- `<C-w>|` - Maximize width
- `<C-w>q` - Close current window
- `<C-w>o` - Close all other windows

---

## 6. Diagnostics & Errors

### Viewing Diagnostics
- `<Space>q` - **Open Quickfix List** - Show all diagnostics
- `<Space>sd` - **Search Diagnostics** - Fuzzy find diagnostics

### Navigating Errors
- `]d` - Next diagnostic (if configured)
- `[d` - Previous diagnostic (if configured)
- Hover over error - Shows diagnostic details

---

## 7. Debugging Workflows

### Workflow 1: Understanding New Code
1. `\` - Open Neo-tree to see project structure
2. Navigate to file and press Enter to open
3. Hover over a function to see its signature
4. `grd` - Jump to definition
5. `grr` - See all usages
6. `gO` - Browse all symbols in file
7. `<C-t>` - Jump back to where you were

### Workflow 2: Tracking Down a Bug
1. `<Space>sg` - Search for error message or function name
2. Navigate to suspicious file
3. `<Space>/` - Search within the file
4. `grd` - Jump to definition to understand logic
5. `grr` - Find all references to see how it's called
6. `<Space>sd` - Check for related diagnostics

### Workflow 3: Refactoring Code
1. `<Space>sw` - Find all occurrences of symbol
2. `grr` - Get precise references from LSP
3. `grn` - Rename across entire project
4. `gra` - Check for available refactoring actions
5. `<Space>sg` - Verify changes with grep

### Workflow 4: Exploring a Project
1. `\` - Open Neo-tree file explorer
2. Browse directory structure visually
3. `<Space>sf` - Fuzzy find files by name
4. `gW` - Search for symbols across workspace
5. `<Space><Space>` - Switch between open buffers

---

## 8. Additional Tips

### Marks (Bookmarks)
- `m{a-z}` - Set local mark (e.g., `ma`)
- `'{a-z}` - Jump to mark (e.g., `'a`)
- `''` - Jump back to previous position

### Helpful Commands
- `:checkhealth` - Verify nvim setup
- `:Lazy` - Manage plugins
- `:Mason` - Manage LSP servers and tools
- `:Telescope colorscheme` - Change color scheme
- `:help {topic}` - Get help (or use `<Space>sh`)

### Terminal Mode
- `<Esc><Esc>` - Exit terminal mode

---

## 9. Format & Actions

- `<Space>f` - **Format Buffer** - Auto-format current file
- `<Space>th` - **Toggle Inlay Hints** - Show/hide type hints

---

## 10. Frequently Asked Questions (FAQ)

### What is a buffer?

A buffer is a file loaded into memory in Neovim. When you open a file, it becomes a buffer. You can have multiple buffers open at once, even if only one is visible. Think of buffers as your open files/tabs.

### What is fuzzy search in current buffer?

Fuzzy search in current buffer (`<Space>/`) searches for text within the file you're currently editing. It shows you matching lines as you type and lets you jump to them. For example, if you're editing a large file and want to find a function name, you can press `<Space>/`, type part of the function name, and it will show you all matching lines with a preview.

It's like Ctrl+F (find) but more powerful - you don't need to type the exact text, just enough characters to match what you're looking for.

---

## Quick Access to This Guide

From nvim: `<Space>sn` then type "NAVIGATION"
````

## File: README.md
````markdown
# kickstart.nvim

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>
````
