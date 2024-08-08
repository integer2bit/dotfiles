return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "regex", "markdown", "markdown_inline", "vim" },
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "latex" },
					additional_vim_regex_highlighting = { "latex", "markdown" },
				},
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>nn",
						node_incremental = "<leader>nn",
						scope_incremental = "<leader>rc",
						node_decremental = "<leader>rm",
					},
				},
			})
		end,
	},
}
