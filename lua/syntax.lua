vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.bbcode",
  command = "set filetype=bbcode",
})
