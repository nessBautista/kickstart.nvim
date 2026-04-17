-- Neogit: Magit-like Git interface for Neovim
return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional: nicer diffs
    'nvim-telescope/telescope.nvim', -- optional: pickers
  },
  keys = {
    {
      '<leader>gs',
      function()
        require('neogit').open()
      end,
      desc = '[G]it [S]tatus (Neogit)',
    },
    {
      '<leader>gS',
      function()
        require('neogit').open { kind = 'vsplit' }
      end,
      desc = '[G]it [S]tatus vsplit (Neogit)',
    },
    {
      '<leader>gl',
      function()
        require('neogit').open { 'log' }
      end,
      desc = '[G]it [L]og (Neogit)',
    },
    {
      '<leader>gc',
      function()
        require('neogit').open { 'commit' }
      end,
      desc = '[G]it [C]ommit (Neogit)',
    },
    {
      '<leader>gp',
      function()
        require('neogit').open { 'push' }
      end,
      desc = '[G]it [P]ush (Neogit)',
    },
    {
      '<leader>gP',
      function()
        require('neogit').open { 'pull' }
      end,
      desc = '[G]it [P]ull (Neogit)',
    },
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
    kind = 'tab', -- default open style: 'tab' | 'split' | 'vsplit' | 'floating'
  },
}
