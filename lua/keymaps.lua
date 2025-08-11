vim.g.mapleader = " "

local set = vim.keymap.set

set("n", "<leader><leader>", ":update<CR> :source<CR>", { desc = "Reload config" })

set("n", "<C-k>", ":wincmd k<CR>", { desc = "Move to window above" })
set("n", "<C-j>", ":wincmd j<CR>", { desc = "Move to window below" })
set("n", "<C-h>", ":wincmd h<CR>", { desc = "Move to left window" })
set("n", "<C-l>", ":wincmd l<CR>", { desc = "Move to right window" })

set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line(s) down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line(s) up" })

set("n", "J", "mzJ`z", { desc = "Join lines" })
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up" })
set("n", "n", "nzzzv", { desc = "Next search result" })
set("n", "N", "Nzzzv", { desc = "Previous search result" })

set("n", "<leader>w", ":wa<CR>", { desc = "Save file" })
set("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
set("n", "<leader>x", ":wqa<CR>", { desc = "Save and quit" })
set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit" })

set("n", "<C-a>", "ggVG", { desc = "Select all" })

set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment line" })
set("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })

set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to system clipboard" })
set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Put from system clipboard" })
set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Put before from system clipboard" })
set("x", "<leader>p", [["_dP]], { desc = "Paste from system clipboard and overwrite selection" })
set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
