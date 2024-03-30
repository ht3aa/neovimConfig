-- Define a function to automatically name tmux window to "lvim"
-- function Name_tmux_window(name)
--     vim.fn.system("tmux rename-window -t 'nvim' " .. name)
-- end



-- vim.cmd([[autocmd VimEnter * lua Name_tmux_window('lvim')]])
-- vim.cmd([[autocmd VimLeave * lua Name_tmux_window('bash')]])

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


vim.cmd([[autocmd VimEnter * lua StartVideoTracker()]])
vim.cmd([[autocmd VimLeave * lua StopVideoTracker()]])
vim.cmd([[autocmd VimLeave * lua SaveCodeTracker()]])
