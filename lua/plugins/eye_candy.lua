vim.pack.add {
	"https://github.com/echasnovski/mini.starter",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/refractalize/oil-git-status.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/smjonas/live-command.nvim",
}

local is_ssh = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_CLIENT ~= nil
local is_neovide = vim.g.neovide

if not is_ssh and not is_neovide then
	vim.pack.add {
		-- "https://github.com/sphamba/smear-cursor.nvim",
		"https://github.com/karb94/neoscroll.nvim",
	}
	-- require "smear_cursor".setup()
	require "neoscroll".setup()
end

require "oil-git-status".setup()
require "gitsigns".setup {
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 100,
	},
}
require "mini.icons".setup()
require "live-command".setup {
	commands = {
		Norm = { cmd = "norm" },
		D = { cmd = "d" },
		G = { cmd = "g" },
	},
}

vim.cmd.colorscheme "catppuccin"
local mocha = require "catppuccin.palettes".get_palette "mocha"

local custom_mocha = require "lualine.themes.catppuccin"

custom_mocha.normal.a.bg = mocha.pink
custom_mocha.normal.b.fg = mocha.pink

require "lualine".setup {
	options = {
		theme = custom_mocha,
	},
	sections = {
		lualine_y = { require "utils".today_time },
	},
}
require "render-markdown".setup {
	preset = "obsidian",
	heading = { sign = false },
	code = { language_name = false, sign = false },
}

local starter = require "mini.starter"
local header_art = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]
starter.setup {
	items = {
		{ name = "Oil", action = "Oil", section = "Actions" },
		{
			name = "Files",
			action = function()
				require "mini.pick".builtin.cli {
					command = { "rg", "--files", "--hidden", "--follow", "--glob", "!**/.git/*" },
				}
			end,
			section = "Actions",
		},

		{ name = "Explorer", action = "Pick explorer", section = "Actions" },
		{ name = "New Buffer", action = "enew", section = "Actions" },
		{ name = "Quit Neovim", action = "qa!", section = "Actions" },
		starter.sections.recent_files(5, true, false),
	},
	header = header_art,
	query_updaters = "abcdefghilmnopqrstuvwxyz0123456789_.",
	footer = "",
	content_hooks = {
		starter.gen_hook.adding_bullet("❯ "),
		starter.gen_hook.aligning("center", "center"),
	},
}

vim.cmd([[
  silent! augroup MiniStarterKeymaps
    au!
    au User MiniStarterOpened nmap <buffer> j <Cmd>lua MiniStarter.update_current_item("next")<CR>
    au User MiniStarterOpened nmap <buffer> k <Cmd>lua MiniStarter.update_current_item("prev")<CR>
    au User MiniStarterOpened nmap <buffer> - <Cmd>Oil<CR>
  augroup END
]])

vim.api.nvim_set_hl(0, "MiniStarterHeader", { fg = mocha.pink })
