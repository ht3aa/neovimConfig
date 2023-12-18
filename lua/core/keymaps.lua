lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<C-n>"] = ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>"
lvim.keys.visual_mode["p"] = '"_dP'
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"
lvim.keys.insert_mode["jj"] = "<ESC>"

