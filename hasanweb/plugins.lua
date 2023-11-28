lvim.plugins = {
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'morhetz/gruvbox' },
  {
    'nvim-lualine/lualine.nvim',
  },
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
