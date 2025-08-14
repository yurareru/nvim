local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.readdir(plugin_dir, [[v:val =~ "\.lua$"]])) do
    local modname = "plugins." .. file:gsub("%.lua$", "")
    require(modname)
end

vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Open find files window" })
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Open buffers window" })
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Open help window" })
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Open live grep window" })
vim.keymap.set("n", "<leader>fd", ":Pick diagnostic<CR>", { desc = "Open diagnostic window" })
vim.keymap.set("n", "<leader>fe", ":Pick explorer<CR>", { desc = "Open explorer window" })
vim.keymap.set("n", "<leader>fH", require("mini.starter").open, { desc = "Open starter homepage" })
