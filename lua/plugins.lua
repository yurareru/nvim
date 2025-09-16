require "plugins.essentials"
require "plugins.cmp"
require "plugins.eye_candy"
require "plugins.misc"

local set = vim.keymap.set
set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })
set("n", "<leader>e", ":Oil<CR>", { desc = "Open parent directory" })

set("n", "<leader>ff", function()
	require "mini.pick".builtin.cli { command = { "rg", "--files", "--hidden", "--follow", "--glob", "!**/.git/*" } }
end, { desc = "Open find files window" })

set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Open buffers window" })
set("n", "<leader>fh", ":Pick help<CR>", { desc = "Open help window" })
set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Open live grep window" })
set("n", "<leader>fd", ":Pick diagnostic<CR>", { desc = "Open diagnostic window" })
set("n", "<leader>fe", ":Pick explorer<CR>", { desc = "Open explorer window" })
set("n", "<leader>fH", require "mini.starter".open, { desc = "Open starter homepage" })

set("n", "<leader>cf", require "conform".format, { desc = "Format current file" })
set("n", "<leader>?", require "which-key".show, { desc = "Buffer Local Keymaps (which-key)" }, { global = false })
set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Navigate left" })
set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Navigate Right" })
set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Navigate Down" })
set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Navigate Up" })
