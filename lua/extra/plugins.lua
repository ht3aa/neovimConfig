lvim.plugins = {
  {
    "diepm/vim-rest-console"
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,

  },
  {
    "stevearc/oil.nvim"
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>oo", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>ot", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>of", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>od", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>os", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>oa", function() harpoon:list():select(4) end)
    end
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "wrxck/telegram-bot-lua"
  },
  {
    "rcarriga/nvim-notify"
  },
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
