vim.lsp.config["clangd"] = {
    cmd = { "clangd", "--clang-tidy", "--header-insertion=never" }
}

vim.diagnostic.config({
    virtual_text = { prefix = '●' },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN] = "⚠",
            [vim.diagnostic.severity.INFO] = "ℹ",
            [vim.diagnostic.severity.HINT] = "💡",
        }
    }
})
