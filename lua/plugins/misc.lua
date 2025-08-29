vim.pack.add {
	"https://github.com/wakatime/vim-wakatime",
	"https://github.com/vyfor/cord.nvim",
	"https://github.com/echasnovski/mini.extra",
	"https://github.com/echasnovski/mini.visits",
	"https://github.com/christoomey/vim-tmux-navigator",
}

require "mini.extra".setup()
require "mini.visits".setup()
require "cord".setup {
	timestamp = { shared = true },
	idle = { enabled = false },
}
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(opts)
		if opts.data.spec.name == "cord.nvim" and opts.data.kind == "update" then
			vim.cmd "Cord update"
		end
	end,
})
