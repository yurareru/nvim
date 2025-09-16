local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- autocmd("BufWritePre", {
--  group = augroup,
-- 	desc = "Auto format on write",
-- 	callback = function(args)
-- 		vim.lsp.buf.format()
-- 	end,
-- })

-- autocmd("FocusLost", { group = augroup, desc = "Auto write on blur", pattern = "*", command = "silent! wa" })

autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight yanked test",
	callback = function()
		vim.hl.on_yank({ higroup = "CurSearch", timeout = 200 })
	end,
})

autocmd("FileType", {
	group = augroup,
	desc = "Disable comment on new line",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

autocmd("FileType", {
	group = augroup,
	pattern = { "html", "css", "javascript", "typescript", "vue" },
	callback = function()
		require "utils".set_buffer_tab_size(2)
	end,
})
