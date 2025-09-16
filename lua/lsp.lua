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
	filetypes = { "vue" },
}
local ts_ls = { init_options = { plugins = { vue_plugin } } }
local clangd = { cmd = { "clangd", "--clang-tidy", "--header-insertion=never" } }

lsp.config("clangd", clangd)
lsp.config("vtsls", vtsls)
lsp.config("ts_ls", ts_ls)

diagnostic.config {
	virtual_text = { prefix = "●" },
	severity_sort = true,
	signs = { text = { "", "", "", "" } },
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})
