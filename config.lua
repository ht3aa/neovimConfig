reload "core.alpha"
reload "core.keymaps"
reload "core.lir"
reload "core.lsp"
reload "core.options"
reload "core.telescope"
reload "core.whichKey"
reload "core.bufferline"
reload "extra"

lvim.builtin.nvimtree.setup.view.side = "right"

-- vim.cmd([[autocmd VimEnter * lue StartVideoTracker()]])
-- vim.cmd([[autocmd VimLeave * lua StopVideoTracker()]])





vim.cmd([[autocmd VimLeave * lua SaveTypingTracker()]])
vim.cmd([[autocmd TextChanged,TextChangedI * lua Update_typing_productivity_seconds()]])
