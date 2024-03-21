lvim.plugins = {
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    config = function()
      require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = "/home/hasanweb/.local/share/lunarvim/site/pack/lazy/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/opt/vscode-js-debug"), -- Path to vscode-js-debug installation.
        -- print(vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"));
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          }
        }
      end
    end
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
    opts = {
      action_keys = {                         -- key mappings for actions in the trouble list
        jump = { "l", "h", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
      }
    },
  },
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
