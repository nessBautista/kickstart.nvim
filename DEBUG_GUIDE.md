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

### Python-specific keymaps

| Keymap | Action | Description |
|--------|--------|-------------|
| `<Space>dm` | **Debug test Method** | Debug the pytest/unittest method under the cursor |
| `<Space>df` | **Debug test class (F)** | Debug the whole test class under the cursor |

---

## Prerequisites

### Python Debugging

1. **Python 3 installed**:
   ```bash
   python3 --version
   ```

2. **debugpy will be auto-installed** by Mason when you restart nvim

3. **uv / virtualenv auto-detection**: the config prefers `./.venv/bin/python`, then `./venv/bin/python`, and falls back to system `python3`. In a uv project, install debugpy into the project so that interpreter can see it:
   ```bash
   uv add --dev debugpy
   uv sync
   ```
   See the [Python + uv Workflow](#python--uv-workflow) section for the full loop.

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

The config also ships two built-in launch configurations you'll see when you press `<Space>dc` in a Python buffer:
- **Launch current file** — runs the current buffer under the detected interpreter.
- **Launch file with args** — same, but prompts for CLI arguments first.

Both set `pythonPath` dynamically, so they follow `.venv/bin/python` on a per-project basis without a reload.

---

## Python + uv Workflow

The debug config is uv-aware. When a session starts it looks for `./.venv/bin/python` (uv's default layout), then `./venv/bin/python`, and only falls back to system `python3` if neither exists. That means you don't have to hard-code interpreter paths per project — just launch nvim from the project root.

### One-time project setup

Add debugpy to the uv project so the project interpreter can import it:

```bash
uv add --dev debugpy
uv sync
```

Mason's debugpy lives in its own environment and is **not** visible to `.venv/bin/python`. Without the step above you'll get `No module named debugpy` on launch.

Optional but useful for the test-debug keymaps:

```bash
uv add --dev pytest
```

### Debug the current file

1. `cd` into your uv project (must contain `.venv/`) and open nvim.
2. `<Space>b` on the line of interest.
3. `<Space>dc` → pick **Launch current file**.

The debugger launches `.venv/bin/python ${file}` under debugpy. `nvim-dap-virtual-text` annotates variables inline; the dap-ui panels open automatically.

### Debug a single test

With pytest in the venv:

- `<Space>dm` — debug the test **method** under the cursor (e.g. `test_foo` inside a class).
- `<Space>df` — debug the whole test **class** under the cursor.

Both run via `nvim-dap-python`, which resolves the test selector and hands it to debugpy — you don't need to write a launch config.

### Lightweight escape hatch: `breakpoint()` + `uv run`

For trivial pokes where the full UI is overkill, drop a literal `breakpoint()` in your code and run the script directly:

```bash
uv run python your_script.py
```

You get a plain pdb prompt in the terminal, using the same project env. No DAP involved — handy for one-off inspections.

### Troubleshooting the uv path

If a launch uses the wrong interpreter:

```bash
# From the project root Neovim was launched in:
ls -la .venv/bin/python
# Confirm debugpy is importable:
.venv/bin/python -c "import debugpy; print(debugpy.__version__)"
```

The resolver uses `vim.fn.getcwd()`, so if you `:cd` away from the project root in nvim, new launches will re-resolve against the new cwd.

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

### Inline virtual text

`nvim-dap-virtual-text` is installed, so while a debug session is active you'll see current variable values rendered inline next to the relevant lines in your buffer — no need to switch to the Scopes panel for a quick peek.

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

The config launches debugpy with whichever interpreter it detected (`.venv/bin/python` when one exists), so debugpy must be installed in *that* environment — Mason's copy is only visible to Mason's python. Fix:
```bash
# Inside a uv project:
uv add --dev debugpy
# Or for a plain venv:
.venv/bin/python -m pip install debugpy
```

**Problem**: Wrong Python interpreter

The resolver picks the first match from: `./.venv/bin/python` → `./venv/bin/python` → `python3`. Check which one is winning:
```bash
ls -la .venv/bin/python venv/bin/python 2>/dev/null
```
If none exist in the current working directory, the debugger uses system `python3`. Either `cd` into the project root before launching nvim, or create the venv (`uv sync` for uv projects).

**Problem**: Breakpoints not hitting
- Ensure file is saved before debugging
- Check that you're running the correct file
- Verify debugpy is installed in the **project venv**, not just Mason: `.venv/bin/python -c "import debugpy"` should succeed

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
