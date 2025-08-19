local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
    desc = "Auto format on write",
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- autocmd('FocusLost', { pattern = '*', command = 'silent! wa' })

augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    desc = "Highlight yanked test",
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 200, })
    end,
})
