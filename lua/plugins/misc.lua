vim.pack.add {
	"https://github.com/wakatime/vim-wakatime",
	"https://github.com/vyfor/cord.nvim",
	"https://github.com/echasnovski/mini.extra",
	"https://github.com/christoomey/vim-tmux-navigator",
}

require "mini.extra".setup()
require "cord".setup {
	timestamp = { shared = true },
	idle = {
		details = function(opts)
			local name = opts.filename ~= nil and opts.filename ~= "" and opts.filename or opts.name
			return "Idling in " .. name
		end,
		unidle_on_focus = false,
	},
	display = { theme = "catppuccin" },
	plugins = {
		["cord.plugins.persistent_timer"] = {
			scope = "global",
			mode = "active",
		},
	},
}
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(opts)
		if opts.data.spec.name == "cord.nvim" and opts.data.kind == "update" then
			vim.cmd "Cord update"
		end
	end,
})
