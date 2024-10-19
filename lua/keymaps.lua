vim.g.mapleader = " "
vim.keymap.set("n", "<leader><leader>", "<cmd>so<cr>", { desc = "Reload config" })

vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>")

vim.keymap.set("v", "J", "<cmd>m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", "<cmd>m '<-2<cr>gv=gv")

-- Keep the cursor in middle
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste from system clipboard and overwrite selection" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
