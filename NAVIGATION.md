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
- `H` - Toggle hidden files (shown by default)
- `?` - Show help (all keymaps)

**Note**: Hidden files (like `.vscode`, `.git`) are visible by default.

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
