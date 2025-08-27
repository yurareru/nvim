local set = vim.keymap.set
local api = vim.api

vim.g.mapleader = " "

set("n", "<leader><leader>", ":update<CR> :source<CR>", { desc = "Reload config" })
set("n", "<leader>rc", ":tabedit $MYVIMRC<CR>", { desc = "Open Neovim config in new tab" })
set("n", "<leader>i", function()
	local enabled = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not enabled)
	vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"))
end, { desc = "Toggle inlay hints" })

set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definiton" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

set("n", "J", "mzJ`z", { desc = "Join lines" })
set("n", "n", "nzzzv", { desc = "Next search result" })
set("n", "N", "Nzzzv", { desc = "Previous search result" })
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up" })

set("n", "<leader>w", ":wa<CR>", { desc = "Save file" })
set("n", "<leader>q", ":q<CR>", { desc = "Quit window" })
set("n", "<leader>x", ":wqa<CR>", { desc = "Save and quit" })
set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit" })
set("n", "<Leader>W", function()
	vim.cmd "write !sudo tee % > /dev/null"
	vim.cmd "edit!"
end, { desc = "Write with sudo" })

set("n", "<C-a>", "ggVG", { desc = "Select all" })
set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment line" })
set("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })

set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
set("n", "<leader>bd", function()
	vim.cmd "bdelete"
	if api.nvim_buf_get_name(0) == "" then
		require "mini.starter".open()
	end
end, { desc = "Delete buffer" })
set("n", "<leader>ba", function()
	for _, buf in ipairs(api.nvim_list_bufs()) do
		if api.nvim_buf_is_loaded(buf) then
			api.nvim_buf_delete(buf, {})
		end
	end
	require "mini.starter".open()
end, { desc = "Delete all buffers" })
set("n", "<leader>bo", function()
	for _, buf in ipairs(api.nvim_list_bufs()) do
		if buf ~= api.nvim_get_current_buf() and api.nvim_buf_is_loaded(buf) then
			api.nvim_buf_delete(buf, {})
		end
	end
end, { desc = "Delete other buffers" })

set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

set("n", "<C-k>", ":wincmd k<CR>", { desc = "Move to window above" })
set("n", "<C-j>", ":wincmd j<CR>", { desc = "Move to window below" })
set("n", "<C-h>", ":wincmd h<CR>", { desc = "Move to left window" })
set("n", "<C-l>", ":wincmd l<CR>", { desc = "Move to right window" })

set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
set("n", "<leader>tm", ":tabmove<CR>", { desc = "Move tab" })
set("n", "<leader>t>", ":tabmove +1<CR>", { desc = "Move tab right" })
set("n", "<leader>t<", ":tabmove -1<CR>", { desc = "Move tab left" })

set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank selection to system clipboard" })
set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Put from system clipboard" })
set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Put before from system clipboard" })
set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

set("n", "<leader>D", function()
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
