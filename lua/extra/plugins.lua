lvim.plugins = {
  {
    "ht3aa/productivity.nvim"
  },
  {
    "kkharji/sqlite.lua"
  },
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  {
    "mxsdev/nvim-dap-vscode-js",
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
  },
}
