local harpoon = require("harpoon")


-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>oa", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>ot", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>og", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>of", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>od", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>os", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>or", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>oe", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>ow", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>oq", function() harpoon:list():select(8) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
