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

lvim.builtin.telescope.pickers.buffers = {
  initial_mode = "insert",
  mappings = {
    i = {
      ["<C-d>"] = actions.delete_buffer,
    },
    n = {
      ["dd"] = actions.delete_buffer,
    },
  },
}

