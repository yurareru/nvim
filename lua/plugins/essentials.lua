vim.pack.add {
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/echasnovski/mini.pick",
	"https://github.com/nvim-mini/mini.clue",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/numToStr/Comment.nvim",
}

function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require "oil".get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		return vim.api.nvim_buf_get_name(0)
	end
end

local detail = false
require "oil".setup {
	delete_to_trash = true,
	win_options = {
		signcolumn = "yes:2",
		winbar = "%!v:lua.get_oil_winbar()",
	},
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["<C-p>"] = {
			"actions.preview",
			opts = { split = "botright" }, -- open preview in a right-hand vertical split
		},
		["gd"] = {
			desc = "Toggle file detail view",
			callback = function()
				detail = not detail
				if detail then
					require "oil".set_columns { "icon", "permissions", "size", "mtime" }
				else
					require "oil".set_columns { "icon" }
				end
			end,
		},
	},
}

require "mini.pick".setup()
local miniclue = require "mini.clue"
miniclue.setup {
	window = {
		delay = 200,
		config = {
			anchor = "SW",
			width = 50,
			row = "auto",
			col = "auto",
		},
	},
	triggers = {
		{ mode = "n", keys = "<leader>" },
		{ mode = "x", keys = "<leader>" },
		{ mode = "i", keys = "<C-x>" },
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		{ mode = "n", keys = "<leader>b", desc = "+Buffers" },
		{ mode = "n", keys = "<leader>D", desc = "+Diagnostics" },
		{ mode = "n", keys = "<leader>s", desc = "+Splits" },
		{ mode = "n", keys = "<leader>t", desc = "+Tabs" },
		{ mode = "n", keys = "<leader>f", desc = "+Find" },
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
}
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
		tex = { "tex-fmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}

require "Comment".setup()
