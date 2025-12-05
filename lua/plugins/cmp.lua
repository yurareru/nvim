vim.pack.add {
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/windwp/nvim-autopairs",
}

require "nvim-autopairs".setup()
require "luasnip.loaders.from_vscode".lazy_load()
require "luasnip.loaders.from_lua".load { paths = vim.fn.stdpath("config") .. "/lua/snippets/" }
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
			snippets = { min_keyword_length = 2, score_offset = 4 },
			lsp = { min_keyword_length = 1, score_offset = 3 },
			path = { min_keyword_length = 3, score_offset = 2 },
			buffer = { min_keyword_length = 5, score_offset = 1 },
		},
	},
}

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(opts)
		if opts.data.spec.name == "blink.cmp" and opts.data.kind == "update" then
			vim.cmd "BlinkCmp build"
		end
	end,
})
