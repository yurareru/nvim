local set = vim.keymap.set
local api = vim.api

vim.g.mapleader = " "

-- Configs
set("n", "<leader><leader>", ":update<CR> :source<CR>", { desc = "Reload config" })
set("n", "<leader>rc", ":tabedit $MYVIMRC<CR>", { desc = "Open Neovim config in new tab" })

-- VSCode probably
set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
set("n", "<C-a>", "ggVG", { desc = "Select all" })
set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle line comment" })
set("v", "<C-_>", "gb", { remap = true, desc = "Toggle block comment" })

-- Center view
set("n", "J", "mzJ`z", { desc = "Join lines" })
set("n", "n", "nzzzv", { desc = "Next search result" })
set("n", "N", "Nzzzv", { desc = "Previous search result" })
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up" })

-- File management
set("n", "<leader>w", ":wa<CR>", { desc = "Save file" })
set("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
set("n", "<leader>x", ":wqa<CR>", { desc = "Save and quit" })
set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit" })

-- Clipboard
set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to system clipboard" })
set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Put from system clipboard" })
set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Put before from system clipboard" })
set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Windows/Panes
set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Tabs
set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
set("n", "<leader>tm", ":tabmove<CR>", { desc = "Move tab" })
set("n", "<leader>t>", ":tabmove +1<CR>", { desc = "Move tab right" })
set("n", "<leader>t<", ":tabmove -1<CR>", { desc = "Move tab left" })

set("n", "<leader>ts2", function()
	require "utils".set_buffer_tab_size(2)
end, { desc = "Set current buffer tab size to 2 spaces" })

set("n", "<leader>ts4", function()
	require "utils".set_buffer_tab_size(4)
end, { desc = "Set current buffer tab size to 4 spaces" })

-- Buffers
set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

set("n", "<leader>bd", function()
	require "utils".delete_buffer()
end, { desc = "Delete buffer" })

set("n", "<leader>ba", function()
	require "utils".delete_all_buffers()
end, { desc = "Delete all buffers" })

set("n", "<leader>bo", function()
	require "utils".delete_other_buffers()
end, { desc = "Delete other buffers" })

-- LSP
set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definiton" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

set("n", "<leader>i", function()
	local enabled = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not enabled)
	vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"))
end, { desc = "Toggle inlay hints" })

set("n", "<leader>Dt", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({
		virtual_text = not current,
	})
	vim.notify("Inline diagnostics " .. (current and "disabled" or "enabled"))
end, { desc = "Toggle inline diagnostics" })

set("n", "<leader>Dy", function()
	local line = api.nvim_win_get_cursor(0)[1]
	local buf = vim.diagnostic.open_float()
	if not buf then
		vim.notify(("No diagnostics on line %s"):format(line), vim.log.levels.ERROR)
		return
	end

	local lines = api.nvim_buf_get_lines(buf, 0, -1, true)

	if vim.fn.setreg("+", lines) ~= 0 then
		vim.notify(("An error happened while trying to copy the diagnostics on line %s"):format(line))
		return
	end

	vim.notify(([[Diagnostics from line %s copied to clipboard.

%s]]):format(line, vim.fn.getreg "+"))
end, { desc = "Copy current line diagnostics" })
