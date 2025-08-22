vim.pack.add {
	"https://github.com/echasnovski/mini.starter",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/sphamba/smear-cursor.nvim",
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/refractalize/oil-git-status.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
}

require "oil-git-status".setup()
require "gitsigns".setup()
require "mini.icons".setup()
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
		{ name = "Oil", action = "Oil", section = "Pick" },
		starter.sections.pick(),
		starter.sections.builtin_actions(),
		starter.sections.recent_files(4, true),
	},
	footer = "",
	header = header_art,
}

require "smear_cursor".setup()
require "neoscroll".setup()
vim.cmd.colorscheme "catppuccin"
require "lualine".setup {
	theme = "catppuccin",
	sections = {
		lualine_y = { require "utils.waka".today_time },
	},
}
require "render-markdown".setup {
	preset = "obsidian",
	heading = { sign = false },
	code = { language_name = false, sign = false },
}
