lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config = {
  height = 0.95,
  width = 0.95,
  prompt_position = "bottom",
  preview_cutoff = 120,
  horizontal = {
    mirror = false,
  },
  vertical = {
    mirror = false,
  },
}
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




