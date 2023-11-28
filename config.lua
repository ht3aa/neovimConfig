-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- which key plugin
lvim.builtin.which_key.mappings.l = {
  name = "LSP",
  w = { vim.diagnostic.open_float, "Diagnostic" },
  t = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
  f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
  i = { "<cmd>LspInfo<cr>", "Info" },
  I = { "<cmd>Mason<cr>", "Mason Info" },
  j = {
    "<cmd>lua vim.diagnostic.goto_next()<cr>",
    "Next Diagnostic",
  },
  k = {
    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    "Prev Diagnostic",
  },
  l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
  q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
  r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  S = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "Workspace Symbols",
  },
  e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
}

lvim.builtin.which_key.mappings.u = {
  "<cmd>UndotreeToggle<cr>", "Undo Tree",
}


lvim.builtin.which_key.mappings.i = {
  name = "Vim Fugitive",
  c = { "<cmd>Git commit<cr>", "Commit" },
  s = { "<cmd>Git status<cr>", "Status" },
  a = { "<cmd>Git add .<cr>", "Add all" },
  l = { "<cmd>Git log<cr>", "Log" },
}

lvim.builtin.which_key.mappings.a = {
  "<cmd>AerialToggle<cr>", "Aerial Toggle",
}
--


-- keymaps
lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<C-n>"] = ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>"

lvim.keys.visual_mode["p"] = '"_dP'
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"


lvim.keys.insert_mode["jj"] = "<ESC>"
--



-- lsp

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



--
-- options

vim.opt.relativenumber = true
vim.g.gruvbox_italic = 1
vim.cmd("autocmd BufNewFile,BufReadPost *.templ set filetype=html")


lvim.colorscheme = "ayu-dark"

--
-- plugins

lvim.plugins = {
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'morhetz/gruvbox' }, -- colorscheme
  { 'Shatur/neovim-ayu'}, -- colorscheme
  { 'catppuccin/nvim'}, -- colorscheme
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

--

-- telescope

local actions = require("lvim.utils.modules").require_on_exported_call "telescope.actions"
lvim.builtin.telescope.defaults.mappings.i = {
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-c>"] = actions.close,
  ["<C-n>"] = actions.cycle_history_next,
  ["<C-p>"] = actions.cycle_history_prev,
  ["<C-q>"] = function(...)
    actions.smart_send_to_qflist(...)
    actions.open_qflist(...)
  end,
  ["<CR>"] = actions.select_default,

}



--

