vim.pack.add {
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",
}

require "oil".setup {
	win_options = {
		signcolumn = "yes:2",
	},
	delete_to_trash = true,
}
require "mini.pick".setup()
require "nvim-treesitter.configs".setup {
	-- stylua: ignore
	ensure_installed = {
		"lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash",
        "yaml", "toml", "json", "jsonc",
        "c", "cpp", "rust",
        "html", "css", "javascript", "typescript",
	},
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<Enter>",
			node_incremental = "<Enter>",
			scope_incremental = false,
			node_decremental = "<BS>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
				["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
				["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				["as"] = { query = "@scope", desc = "Select language scope" },
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
	},
}
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(opts)
		-- untested
		if opts.data.spec.name == "nvim-treesitter" and opts.data.kind == "update" then
			vim.cmd "TSUpdate"
		end
	end,
})
require "nvim-treesitter-textobjects"
require "mason".setup()
require "mason-lspconfig".setup {
    -- stylua: ignore
	ensure_installed = {
		"lua_ls", "bashls", "vimls",
		"clangd", "rust_analyzer",
		"html", "cssls", "tailwindcss",
		"ts_ls", "vtsls", "vue_ls",
	},
}
require "conform".setup {
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "prettierd", "prettier" },
		javascript = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}
