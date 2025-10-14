-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Terminal Plugin
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]oggle [T]erminal (float)' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = '[T]oggle [T]erminal (horizontal)' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = '[T]oggle [T]erminal (vertical)' },
      { '<leader>t1', '<cmd>1ToggleTerm<cr>', desc = '[T]erminal [1]' },
      { '<leader>t2', '<cmd>2ToggleTerm<cr>', desc = '[T]erminal [2]' },
      { '<leader>t3', '<cmd>3ToggleTerm<cr>', desc = '[T]erminal [3]' },
      { '<leader>t4', '<cmd>4ToggleTerm<cr>', desc = '[T]erminal [4]' },
    },
    opts = {
      size = 20,
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
      },
    },
  },

  -- Markdown Preview Plugin
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    keys = {
      { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = '[M]arkdown [P]review Toggle' },
    },
    init = function()
      -- Set configuration before plugin loads
      vim.g.mkdp_auto_start = 0 -- Don't auto-open preview
      vim.g.mkdp_auto_close = 1 -- Auto-close preview when changing buffers
      vim.g.mkdp_refresh_slow = 0 -- Fast refresh
      vim.g.mkdp_theme = 'dark' -- Use dark theme (or 'light')
    end,
  },
}
