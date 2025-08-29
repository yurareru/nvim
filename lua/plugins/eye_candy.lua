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
