require "core.alpha"
require "core.lir"
require "core.lsp"
require "core.options"
require "core.telescope"
require "core.whichKey"
require "core.bufferline"
require "core.nvimTree"
require "core.lazygit"
require "core.keymaps"
require "extra"

vim.cmd([[autocmd VimLeave * lua SaveTypingTracker()]])
vim.cmd([[autocmd TextChanged,TextChangedI * lua Update_typing_productivity_seconds()]])
