vim.pack.add {
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/refractalize/oil-git-status.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/echasnovski/mini.pick",
    "https://github.com/folke/which-key.nvim",
}

require "oil".setup {
    win_options = {
        signcolumn = "yes:2"
    },
    delete_to_trash = true
}
require "oil-git-status".setup()
require "mini.pick".setup()
require "nvim-treesitter.configs".setup {
    ensure_installed = { "lua", "cpp", "markdown" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true }
}
require "gitsigns".setup()
