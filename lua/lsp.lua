local lsp = vim.lsp
local diagnostic = vim.diagnostic

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
	languages = { "vue" },
	configNamespace = "typescript",
}
local vtsls = {
	settings = { vtsls = { tsserver = { globalPlugins = { vue_plugin } } } },
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
local ts_ls = { init_options = { plugins = { vue_plugin } } }
local clangd = { cmd = { "clangd", "--clang-tidy", "--header-insertion=never" } }

lsp.config("clangd", clangd)
lsp.config("vtsls", vtsls)
lsp.config("ts_ls", ts_ls)

diagnostic.config {
	virtual_text = { prefix = "●" },
	severity_sort = true,
	signs = {
		text = {
			[diagnostic.severity.ERROR] = "",
			[diagnostic.severity.WARN] = "",
			[diagnostic.severity.INFO] = "",
			[diagnostic.severity.HINT] = "",
		},
	},
}
