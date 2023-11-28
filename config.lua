-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
require "hasanweb.whichKey"
require "hasanweb.keymaps"
require "hasanweb.options"
require "hasanweb.telescope"

-- replace all under cursor word
-- lvim.keys.normal_mode["<leader>ic"] = ":Git commit<CR>"
-- lvim.keys.normal_mode["<leader>il"] = ":Git log<CR>"
-- lvim.keys.normal_mode["<leader>is"] = ":Git status<CR>"
-- lvim.keys.normal_mode["<leader>ia"] = ":Git add .<CR>"
-- lvim.keys.normal_mode["<leader>iw"] = ":Gwrite<CR>"
-- lvim.keys.normal_mode["<leader>a"] = ":AerialToggle right<CR>"

lvim.keys.visual_mode["p"] = '"_dP'
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

lvim.keys.insert_mode["jj"] = "<ESC>"

lvim.colorscheme = "gruvbox"

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
  { 'wakatime/vim-wakatime' },
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

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    args = { "--print-width", "100" },
    filetypes = { "javascript", "html", "vue", "css", "typescript", "typescriptreact" },
  },
  {
    name = "blade_formatter",
    filetypes = { "blade", "php" },
  }
}



local signs = {

  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = false, -- disable virtual text
  signs = {
    active = signs,     -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})


