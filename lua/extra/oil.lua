require("oil").setup({
  columns = { "icon" },
  keymaps = {
    ["<C-h>"] = false,
    ["<ESC>"] = "actions.close",
  },
  view_options = {
    show_hidden = true
  },
})
