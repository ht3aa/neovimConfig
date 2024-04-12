reload "core.alpha"
reload "core.lir"
reload "core.lsp"
reload "core.options"
reload "core.telescope"
reload "core.whichKey"
reload "core.bufferline"
reload "core.nvimTree"
reload "core.lazygit"
reload "extra"
reload "core.keymaps"

vim.notify = require("notify")
vim.cmd([[autocmd VimLeave * lua SaveTypingTracker()]])
vim.cmd([[autocmd TextChanged,TextChangedI * lua Update_typing_productivity_seconds()]])






