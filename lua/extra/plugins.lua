lvim.plugins = {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup()
    end,
  },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'morhetz/gruvbox' },             -- colorscheme
  { 'Shatur/neovim-ayu' },           -- colorscheme
  { 'catppuccin/nvim' },             -- colorscheme
  { 'marko-cerovac/material.nvim' }, -- colorscheme
  { 'rose-pine/neovim' },            -- colorscheme
  { 'ofirgall/ofirkai.nvim' },       -- colorscheme
  { 'zootedb0t/citruszest.nvim' },   -- colorscheme
  {
    'nvim-lualine/lualine.nvim',
  },
  {
    'rcarriga/nvim-notify', -- notification
    config = function()
      require("notify").setup()
      vim.notify = require("notify")
      require("telescope").load_extension("notify")
    end

  },
  { 'stevearc/dressing.nvim' }, -- cool ui for all neovim core stuff
  {
    'stevearc/aerial.nvim',
    config = function()
      require("aerial").setup()
    end
  },
  { 'christoomey/vim-tmux-navigator' },
  {
    'Exafunction/codeium.vim',
    config = function()
      vim.keymap.set('i', '<ESC>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
}
