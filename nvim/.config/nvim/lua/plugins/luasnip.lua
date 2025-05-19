return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	run = "make install_jsregexp",
	event = { "InsertEnter" },
	opts = function()
		require("luasnip.loaders.from_lua").load({
			paths = { vim.fn.stdpath("config") .. "/luasnippets" },
		})
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})
	end,
}
