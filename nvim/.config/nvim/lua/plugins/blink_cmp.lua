return {
	"saghen/blink.cmp",
	dependencies = {
		{ "saghen/blink.compat", lazy = true, version = false },
	},
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<C-n>"] = { "snippet_forward", "fallback" },
			["<C-p>"] = { "snippet_backward", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
		},
		cmdline = {
			keymap = { preset = "inherit" },
			completion = { menu = { auto_show = true } },
		},
		-- Displays a preview of the selected item on the current line
		completion = {
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
					treesitter = { "lsp" },
				},
			},
		},
		signature = {
			enabled = true,
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		snippets = {
			preset = "luasnip",
		},
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"obsidian",
				"obsidian_new",
				"obsidian_tags",
			},
			providers = {
				obsidian = { name = "obsidian", module = "blink.compat.source" },
				obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
				obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
			},
		},
	},
	opts_extend = { "sources.default" },
}
