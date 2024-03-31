lvim.builtin.which_key.mappings.b = { "<cmd>Telescope buffers previewer=false<cr>", "Find Buffer" }
lvim.builtin.which_key.mappings.t = { "<cmd>TroubleToggle<cr>", "Trouble" }
lvim.builtin.which_key.mappings.B = {
  name = "Buffers",
  j = { "<cmd>BufferLinePick<cr>", "Jump" },
  b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
  n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
  W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
  -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
  e = {
    "<cmd>BufferLinePickClose<cr>",
    "Pick which buffer to close",
  },
  h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
  l = {
    "<cmd>BufferLineCloseRight<cr>",
    "Close all to the right",
  },
  D = {
    "<cmd>BufferLineSortByDirectory<cr>",
    "Sort by directory",
  },
  L = {
    "<cmd>BufferLineSortByExtension<cr>",
    "Sort by language",
  },
}
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
  p = { "<cmd>Git push<cr>", "push origin main" },
}
lvim.builtin.which_key.mappings.a = {
  "<cmd>AerialToggle<cr>", "Aerial Toggle",
}

