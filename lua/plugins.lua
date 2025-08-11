vim.pack.add({
    -- can't live without
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/folke/which-key.nvim" },
    -- editor stuff
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    -- flexing probably
    { src = "https://github.com/wakatime/vim-wakatime" },
    { src = "https://github.com/vyfor/cord.nvim" },
    -- eye candy ;)
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/sphamba/smear-cursor.nvim" },
    { src = "https://github.com/karb94/neoscroll.nvim" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/echasnovski/mini.starter" },
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    -- dependencies
    { src = "https://github.com/echasnovski/mini.extra" },
    { src = "https://github.com/echasnovski/mini.visits" }
})

require "oil".setup()
require "mini.pick".setup()
require "nvim-treesitter.configs".setup {
    ensure_installed = { "lua", "cpp", "markdown" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true }
}

require "luasnip.loaders.from_vscode".lazy_load()
require "blink.cmp".setup {
    signature = { enabled = true, window = { border = "rounded" } },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "rounded" } },
        menu = { auto_show = true, border = "rounded" },
    },
    keymap = {
        ["<CR>"] = { "accept", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
    },
    snippets = { preset = "luasnip" },
    -- fuzzy = { implementation = "lua" },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            snippets = {
                min_keyword_length = 2,
                score_offset = 4,
            },
            lsp = {
                min_keyword_length = 3,
                score_offset = 3,
            },
            path = {
                min_keyword_length = 3,
                score_offset = 2,
            },
            buffer = {
                min_keyword_length = 5,
                score_offset = 1,
            }
        }
    }
}

require "mason".setup()
require "mason-lspconfig".setup {
    ensure_installed = { "lua_ls", "clangd" },
}
require "nvim-autopairs".setup()
require "mini.icons".setup()
require "mini.extra".setup()
require "mini.visits".setup()
local starter = require "mini.starter"
starter.setup {
    items = {
        starter.sections.pick(),
        starter.sections.builtin_actions(),
        starter.sections.recent_files(4, true),
    },
    footer = "",
}
require "render-markdown".setup {
    preset = "obsidian",
    heading = { sign = false },
    code = { language_name = false, sign = false }
}
require "cord".setup {
    idle = {
        enable = false
    }
}
require "smear_cursor".setup()
require "neoscroll".setup()
require "lualine".setup { theme = "catppuccin-latte" }
vim.cmd.colorscheme "catppuccin-latte"

vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Open find files window" })
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Open buffers window" })
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Open help window" })
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Open live grep window" })
vim.keymap.set("n", "<leader>fd", ":Pick diagnostic<CR>", { desc = "Open diagnostic window" })
vim.keymap.set("n", "<leader>fe", ":Pick explorer<CR>", { desc = "Open explorer window" })
